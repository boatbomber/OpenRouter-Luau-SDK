"""
Code Formatter for the OpenRouter Luau SDK Generator.

Handles formatting of generated Luau code using stylua.
"""

import logging
import shutil
import subprocess
from pathlib import Path
from typing import List

from generator.errors import FormattingError

logger = logging.getLogger("generator")


class CodeFormatter:
    """
    Formats generated Luau code using stylua.

    Provides a clean interface for code formatting operations.
    """

    def __init__(self, formatter_command: str = "stylua", linter_command: str = "selene"):
        """
        Initialize the code formatter.

        Args:
            formatter_command: Path or command name for stylua (default: "stylua")
            linter_command: Path or command name for selene (default: "selene")
        """
        self.formatter_command = formatter_command
        self.linter_command = linter_command
        self._check_availability()

    def _check_availability(self) -> bool:
        """
        Check if stylua is available in PATH.

        Returns:
            True if stylua is available, False otherwise
        """
        stylua_path = shutil.which(self.formatter_command)
        if not stylua_path:
            logger.warning(
                f"{self.formatter_command} not found in PATH, formatting will be skipped"
            )
            return False
        return True

    def format_file(self, file_path: Path) -> None:
        """
        Format a single file using stylua.

        Args:
            file_path: Path to the file to format

        Raises:
            FormattingError: If formatting fails
        """
        if not self._check_availability():
            logger.warning(f"Skipping formatting for {file_path}")
            return

        try:
            result = subprocess.run(
                [self.formatter_command, str(file_path.absolute())],
                capture_output=True,
                text=True,
                timeout=30,
            )

            if result.returncode == 0:
                logger.debug(f"Formatted {file_path.name}")
            else:
                logger.warning(
                    f"stylua failed for {file_path.name}: {result.stderr}"
                )

        except subprocess.TimeoutExpired:
            logger.warning(f"stylua timed out for {file_path.name}")
        except Exception as e:
            logger.warning(f"Failed to format {file_path.name}: {e}")

    def format_directory(self, directory: Path) -> None:
        """
        Format all files in a directory using stylua.

        Args:
            directory: Path to the directory to format

        Raises:
            FormattingError: If formatting fails
        """
        if not self._check_availability():
            logger.warning(f"Skipping formatting for {directory}")
            return

        try:
            result = subprocess.run(
                [self.formatter_command, str(directory.absolute())],
                capture_output=True,
                text=True,
                timeout=30,
            )

            if result.returncode == 0:
                logger.debug(f"Formatted {directory.name}")
            else:
                logger.warning(
                    f"stylua failed for {directory.name}: {result.stderr}"
                )

        except subprocess.TimeoutExpired:
            logger.warning(f"stylua timed out for {directory.name}")
        except Exception as e:
            logger.warning(f"Failed to format {directory.name}: {e}")

    def format_files(self, file_paths: List[Path], passes: int = 2) -> None:
        """
        Format multiple files using stylua and validate convergence.

        Args:
            file_paths: List of file paths to format
            passes: Number of formatting passes (default: 2, stylua sometimes needs multiple passes)

        Raises:
            FormattingError: If formatting doesn't converge after the specified passes
        """
        if not self._check_availability():
            logger.warning("Skipping formatting")
            return

        # Track file hashes to detect changes
        file_hashes = {}

        for pass_num in range(passes):
            changed_files = []

            for file_path in file_paths:
                # Read content before formatting
                try:
                    content_before = file_path.read_text(encoding="utf-8")
                    hash_before = hash(content_before)
                except Exception as e:
                    logger.warning(f"Could not read {file_path.name} for comparison: {e}")
                    hash_before = None

                # Format the file
                self.format_file(file_path)

                # Read content after formatting
                try:
                    content_after = file_path.read_text(encoding="utf-8")
                    hash_after = hash(content_after)

                    # Track if file changed in this pass
                    if hash_before is not None and hash_before != hash_after:
                        changed_files.append(file_path.name)

                    # Store hash for next pass
                    file_hashes[file_path] = hash_after
                except Exception as e:
                    logger.warning(f"Could not read {file_path.name} after formatting: {e}")

            # Log changes for this pass
            if changed_files:
                logger.debug(f"Pass {pass_num + 1}/{passes}: {len(changed_files)} file(s) changed")
            else:
                logger.debug(f"Pass {pass_num + 1}/{passes}: No changes, formatting converged")
                return

        # If we got here, we ran all passes and the last pass still had changes
        if changed_files:
            warning_msg = (
                f"Formatting did not converge after {passes} passes. "
                f"Files still changing: {', '.join(changed_files)}. "
                f"Consider increasing the number of passes or investigating stylua behavior."
            )
            logger.warning(warning_msg)

    def validate_with_selene(self, directory: Path) -> None:
        """
        Validate Luau files using selene linter.

        Args:
            directory: Directory containing Luau files to validate

        Raises:
            FormattingError: If selene is not available or validation fails
        """
        # Check if selene is available
        selene_path = shutil.which(self.linter_command)
        if not selene_path:
            error_msg = (
                f"{self.linter_command} not found in PATH. "
                f"Please install selene to validate generated files."
            )
            logger.error(error_msg)
            raise FormattingError(error_msg)

        logger.info(f"Validating files with {self.linter_command}...")

        try:
            result = subprocess.run(
                [self.linter_command, str(directory.absolute())],
                capture_output=True,
                text=True,
                timeout=30,
            )

            # Log output
            if result.stdout:
                logger.debug(f"selene stdout:\n{result.stdout}")
            if result.stderr:
                logger.debug(f"selene stderr:\n{result.stderr}")

            # Check exit code
            if result.returncode != 0:
                error_msg = (
                    f"Selene validation failed with exit code {result.returncode}.\n"
                    f"Output: {result.stdout}\n"
                    f"Errors: {result.stderr}"
                )
                logger.error(error_msg)
                raise FormattingError(error_msg)

            logger.info(f"✓ Selene validation passed")

        except subprocess.TimeoutExpired:
            error_msg = f"selene timed out for {directory}"
            logger.error(error_msg)
            raise FormattingError(error_msg)
        except FormattingError:
            # Re-raise FormattingErrors
            raise
        except Exception as e:
            error_msg = f"Failed to run selene on {directory}: {e}"
            logger.error(error_msg)
            raise FormattingError(error_msg) from e

"""
Graph algorithms for the OpenRouter Luau SDK Generator.
"""

from collections import defaultdict
from typing import Dict, List, Set

from generator.errors import CircularDependencyError


def topological_sort(dependencies: Dict[str, List[str]]) -> List[str]:
    """
    Topological sort where dependencies[A] = [B, C] means
    "A depends on B and C" (A must come AFTER B and C).

    Returns items in order where dependencies come before dependents.

    Args:
        dependencies: Dictionary mapping item names to their dependencies

    Returns:
        List of items in topologically sorted order

    Raises:
        CircularDependencyError: If circular dependencies are detected
    """
    # Build reverse graph (who depends on me)
    dependents: Dict[str, Set[str]] = defaultdict(set)
    in_degree = {item: 0 for item in dependencies}

    for item, deps in dependencies.items():
        in_degree[item] = len(deps)
        for dep in deps:
            if dep in dependencies:  # Only track deps that are in our graph
                dependents[dep].add(item)

    # Start with items that have no dependencies
    queue = [item for item, degree in in_degree.items() if degree == 0]
    result = []

    while queue:
        queue.sort()  # Deterministic ordering
        current = queue.pop(0)
        result.append(current)

        # Reduce in-degree for items depending on current
        for dependent in dependents[current]:
            in_degree[dependent] -= 1
            if in_degree[dependent] == 0:
                queue.append(dependent)

    # Check for circular dependencies
    if len(result) != len(dependencies):
        remaining = set(dependencies.keys()) - set(result)
        raise CircularDependencyError(f"Circular dependencies detected: {remaining}")

    return result

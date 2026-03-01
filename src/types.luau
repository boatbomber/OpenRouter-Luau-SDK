--!strict
-- This file is auto-generated from OpenRouter API
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: 2026-03-01T00:37:38.906685Z (generator v1.0.0)
-- Documentation: https://openrouter.ai/docs - OpenRouter Documentation

--[[
  OpenAI-compatible API with additional OpenRouter features
]]

--- @class OpenRouterTypes
--- The OpenRouterTypes contains auto-generated types from the OpenRouter APIs.

export type ResultOk<T> = { type: "ok", value: T } -- Request succeeded
export type ResultErr<E> = { type: "err", error: E } -- Request responded with an error
export type ResultCrash = { type: "crash", error: string } -- Request failed to send
export type Result<T, E> = ResultOk<T> | ResultErr<E> | ResultCrash

export type HttpMethod = "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "OPTIONS" | "TRACE" | "PATCH"

--[=[
    @interface ActivityItem
    @within OpenRouterTypes
    
    @field date string -- Date of the activity (YYYY-MM-DD format); (Ex: "2025-08-24")
    @field model string -- Model slug (e.g., "openai/gpt-4.1"); (Ex: "openai/gpt-4.1")
    @field model_permaslug string -- Model permaslug (e.g., "openai/gpt-4.1-2025-04-14"); (Ex: "openai/gpt-4.1-2025-04-14")
    @field endpoint_id string -- Unique identifier for the endpoint; (Ex: "550e8400-e29b-41d4-a716-446655440000")
    @field provider_name string -- Name of the provider serving this endpoint; (Ex: "OpenAI")
    @field usage number -- Total cost in USD (OpenRouter credits spent); (Ex: 0.015)
    @field byok_usage_inference number -- BYOK inference cost in USD (external credits spent); (Ex: 0.012)
    @field requests number -- Number of requests made; (Ex: 5)
    @field prompt_tokens number -- Total prompt tokens used; (Ex: 50)
    @field completion_tokens number -- Total completion tokens generated; (Ex: 125)
    @field reasoning_tokens number -- Total reasoning tokens used; (Ex: 25)
]=]
export type ActivityItem = {
	date: string,
	model: string,
	model_permaslug: string,
	endpoint_id: string,
	provider_name: string,
	usage: number,
	byok_usage_inference: number,
	requests: number,
	prompt_tokens: number,
	completion_tokens: number,
	reasoning_tokens: number,
}

--[=[
    @type AnthropicMessagesStreamEvent ({ ["type"]: "message_start", message: { id: string, ["type"]: "message", role: "assistant", content: {({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number, file_id: string? } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number, file_id: string? } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number, file_id: string? } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}? } | { ["type"]: "tool_use", id: string, name: string, input: any? } | { ["type"]: "thinking", thinking: string, signature: string } | { ["type"]: "redacted_thinking", data: string } | { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? } | { ["type"]: "web_search_tool_result", tool_use_id: string, content: ({{ ["type"]: "web_search_result", encrypted_content: string, page_age: string?, title: string, url: string }} | { ["type"]: "web_search_tool_result_error", error_code: ("invalid_tool_input" | "unavailable" | "max_uses_exceeded" | "too_many_requests" | "query_too_long") }) })}, model: string, stop_reason: any?, stop_sequence: any?, usage: { input_tokens: number, output_tokens: number, cache_creation_input_tokens: number?, cache_read_input_tokens: number?, cache_creation: { ephemeral_5m_input_tokens: number, ephemeral_1h_input_tokens: number }?, inference_geo: string?, server_tool_use: { web_search_requests: number }?, service_tier: ("standard" | "priority" | "batch")? } } } | { ["type"]: "message_delta", delta: { stop_reason: ("end_turn" | "max_tokens" | "stop_sequence" | "tool_use" | "pause_turn" | "refusal")?, stop_sequence: string? }, usage: { input_tokens: number?, output_tokens: number, cache_creation_input_tokens: number?, cache_read_input_tokens: number?, server_tool_use: { web_search_requests: number }? } } | { ["type"]: "message_stop" } | { ["type"]: "content_block_start", index: number, content_block: ({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number, file_id: string? } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number, file_id: string? } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number, file_id: string? } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}? } | { ["type"]: "tool_use", id: string, name: string, input: any? } | { ["type"]: "thinking", thinking: string, signature: string } | { ["type"]: "redacted_thinking", data: string } | { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? } | { ["type"]: "web_search_tool_result", tool_use_id: string, content: ({{ ["type"]: "web_search_result", encrypted_content: string, page_age: string?, title: string, url: string }} | { ["type"]: "web_search_tool_result_error", error_code: ("invalid_tool_input" | "unavailable" | "max_uses_exceeded" | "too_many_requests" | "query_too_long") }) }) } | { ["type"]: "content_block_delta", index: number, delta: ({ ["type"]: "text_delta", text: string } | { ["type"]: "input_json_delta", partial_json: string } | { ["type"]: "thinking_delta", thinking: string } | { ["type"]: "signature_delta", signature: string } | { ["type"]: "citations_delta", citation: ({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number, file_id: string? } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number, file_id: string? } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number, file_id: string? } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number }) }) } | { ["type"]: "content_block_stop", index: number } | { ["type"]: "ping" } | { ["type"]: "error", error: { ["type"]: string, message: string } })
    @within OpenRouterTypes
    Union of all possible streaming events
]=]
export type AnthropicMessagesStreamEvent =
	{
		["type"]: "message_start",
		message: {
			id: string,
			["type"]: "message",
			role: "assistant",
			content: {
				(
					{
						["type"]: "text",
						text: string,
						citations: {
							{
								["type"]: "char_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_char_index: number,
								end_char_index: number,
								file_id: string?,
							} | {
								["type"]: "page_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_page_number: number,
								end_page_number: number,
								file_id: string?,
							} | {
								["type"]: "content_block_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_block_index: number,
								end_block_index: number,
								file_id: string?,
							} | {
								["type"]: "web_search_result_location",
								cited_text: string,
								encrypted_index: string,
								title: string?,
								url: string,
							} | {
								["type"]: "search_result_location",
								cited_text: string,
								search_result_index: number,
								source: string,
								title: string?,
								start_block_index: number,
								end_block_index: number,
							}
						}?,
					}
					| { ["type"]: "tool_use", id: string, name: string, input: any? }
					| { ["type"]: "thinking", thinking: string, signature: string }
					| { ["type"]: "redacted_thinking", data: string }
					| { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? }
					| {
						["type"]: "web_search_tool_result",
						tool_use_id: string,
						content: {
							{
								["type"]: "web_search_result",
								encrypted_content: string,
								page_age: string?,
								title: string,
								url: string,
							}
						} | {
							["type"]: "web_search_tool_result_error",
							error_code: (
								"invalid_tool_input"
								| "unavailable"
								| "max_uses_exceeded"
								| "too_many_requests"
								| "query_too_long"
							),
						},
					}
				)
			},
			model: string,
			stop_reason: any?,
			stop_sequence: any?,
			usage: {
				input_tokens: number,
				output_tokens: number,
				cache_creation_input_tokens: number?,
				cache_read_input_tokens: number?,
				cache_creation: { ephemeral_5m_input_tokens: number, ephemeral_1h_input_tokens: number }?,
				inference_geo: string?,
				server_tool_use: { web_search_requests: number }?,
				service_tier: ("standard" | "priority" | "batch")?,
			},
		},
	}
	| {
		["type"]: "message_delta",
		delta: {
			stop_reason: ("end_turn" | "max_tokens" | "stop_sequence" | "tool_use" | "pause_turn" | "refusal")?,
			stop_sequence: string?,
		},
		usage: {
			input_tokens: number?,
			output_tokens: number,
			cache_creation_input_tokens: number?,
			cache_read_input_tokens: number?,
			server_tool_use: { web_search_requests: number }?,
		},
	}
	| { ["type"]: "message_stop" }
	| {
		["type"]: "content_block_start",
		index: number,
		content_block: (
			{
				["type"]: "text",
				text: string,
				citations: {
					{
						["type"]: "char_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_char_index: number,
						end_char_index: number,
						file_id: string?,
					} | {
						["type"]: "page_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_page_number: number,
						end_page_number: number,
						file_id: string?,
					} | {
						["type"]: "content_block_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_block_index: number,
						end_block_index: number,
						file_id: string?,
					} | {
						["type"]: "web_search_result_location",
						cited_text: string,
						encrypted_index: string,
						title: string?,
						url: string,
					} | {
						["type"]: "search_result_location",
						cited_text: string,
						search_result_index: number,
						source: string,
						title: string?,
						start_block_index: number,
						end_block_index: number,
					}
				}?,
			}
			| { ["type"]: "tool_use", id: string, name: string, input: any? }
			| { ["type"]: "thinking", thinking: string, signature: string }
			| { ["type"]: "redacted_thinking", data: string }
			| { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? }
			| {
				["type"]: "web_search_tool_result",
				tool_use_id: string,
				content: {
					{
						["type"]: "web_search_result",
						encrypted_content: string,
						page_age: string?,
						title: string,
						url: string,
					}
				} | {
					["type"]: "web_search_tool_result_error",
					error_code: (
						"invalid_tool_input"
						| "unavailable"
						| "max_uses_exceeded"
						| "too_many_requests"
						| "query_too_long"
					),
				},
			}
		),
	}
	| {
		["type"]: "content_block_delta",
		index: number,
		delta: (
			{ ["type"]: "text_delta", text: string }
			| { ["type"]: "input_json_delta", partial_json: string }
			| { ["type"]: "thinking_delta", thinking: string }
			| { ["type"]: "signature_delta", signature: string }
			| {
				["type"]: "citations_delta",
				citation: {
					["type"]: "char_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_char_index: number,
					end_char_index: number,
					file_id: string?,
				} | {
					["type"]: "page_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_page_number: number,
					end_page_number: number,
					file_id: string?,
				} | {
					["type"]: "content_block_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_block_index: number,
					end_block_index: number,
					file_id: string?,
				} | {
					["type"]: "web_search_result_location",
					cited_text: string,
					encrypted_index: string,
					title: string?,
					url: string,
				} | {
					["type"]: "search_result_location",
					cited_text: string,
					search_result_index: number,
					source: string,
					title: string?,
					start_block_index: number,
					end_block_index: number,
				},
			}
		),
	}
	| { ["type"]: "content_block_stop", index: number }
	| { ["type"]: "ping" }
	| {
		["type"]: "error",
		error: { ["type"]: string, message: string },
	}

--[=[
    @interface AnthropicOutputConfig
    @within OpenRouterTypes
    Configuration for controlling output behavior. Currently supports the effort parameter for Claude Opus 4.5.
    
    @field effort ("low" | "medium" | "high" | "max")? -- How much effort the model should put into its response. Higher effort levels may result in more thorough analysis but take longer. Valid values are `low`, `medium`, `high`, or `max`.; (Ex: "medium")
]=]
export type AnthropicOutputConfig = { effort: ("low" | "medium" | "high" | "max")? }

--[=[
    @type AssistantMessageImages {{ image_url: { url: string } }}
    @within OpenRouterTypes
    Generated images from image generation models
]=]
export type AssistantMessageImages = { { image_url: { url: string } } }

--[=[
    @interface BadGatewayResponseErrorData
    @within OpenRouterTypes
    Error data for BadGatewayResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type BadGatewayResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface BadGatewayResponse
    @within OpenRouterTypes
    Bad Gateway - Provider/upstream API failure
    
    @field error BadGatewayResponseErrorData
    @field user_id string?
]=]
export type BadGatewayResponse = { error: BadGatewayResponseErrorData, user_id: string? }

--[=[
    @interface BadRequestResponseErrorData
    @within OpenRouterTypes
    Error data for BadRequestResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type BadRequestResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface BadRequestResponse
    @within OpenRouterTypes
    Bad Request - Invalid request parameters or malformed input
    
    @field error BadRequestResponseErrorData
    @field user_id string?
]=]
export type BadRequestResponse = { error: BadRequestResponseErrorData, user_id: string? }

--[=[
    @interface BaseAnthropicMessagesResponse
    @within OpenRouterTypes
    
    @field id string
    @field type "message"
    @field role "assistant"
    @field content {({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number, file_id: string? } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number, file_id: string? } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number, file_id: string? } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}? } | { ["type"]: "tool_use", id: string, name: string, input: any? } | { ["type"]: "thinking", thinking: string, signature: string } | { ["type"]: "redacted_thinking", data: string } | { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? } | { ["type"]: "web_search_tool_result", tool_use_id: string, content: ({{ ["type"]: "web_search_result", encrypted_content: string, page_age: string?, title: string, url: string }} | { ["type"]: "web_search_tool_result_error", error_code: ("invalid_tool_input" | "unavailable" | "max_uses_exceeded" | "too_many_requests" | "query_too_long") }) })}
    @field model string
    @field stop_reason ("end_turn" | "max_tokens" | "stop_sequence" | "tool_use" | "pause_turn" | "refusal")?
    @field stop_sequence string?
    @field usage { input_tokens: number, output_tokens: number, cache_creation_input_tokens: number?, cache_read_input_tokens: number?, cache_creation: { ephemeral_5m_input_tokens: number, ephemeral_1h_input_tokens: number }?, inference_geo: string?, server_tool_use: { web_search_requests: number }?, service_tier: ("standard" | "priority" | "batch")? }
]=]
export type BaseAnthropicMessagesResponse = {
	id: string,
	["type"]: "message",
	role: "assistant",
	content: {
		(
			{
				["type"]: "text",
				text: string,
				citations: {
					{
						["type"]: "char_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_char_index: number,
						end_char_index: number,
						file_id: string?,
					} | {
						["type"]: "page_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_page_number: number,
						end_page_number: number,
						file_id: string?,
					} | {
						["type"]: "content_block_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_block_index: number,
						end_block_index: number,
						file_id: string?,
					} | {
						["type"]: "web_search_result_location",
						cited_text: string,
						encrypted_index: string,
						title: string?,
						url: string,
					} | {
						["type"]: "search_result_location",
						cited_text: string,
						search_result_index: number,
						source: string,
						title: string?,
						start_block_index: number,
						end_block_index: number,
					}
				}?,
			}
			| { ["type"]: "tool_use", id: string, name: string, input: any? }
			| { ["type"]: "thinking", thinking: string, signature: string }
			| { ["type"]: "redacted_thinking", data: string }
			| { ["type"]: "server_tool_use", id: string, name: "web_search", input: any? }
			| {
				["type"]: "web_search_tool_result",
				tool_use_id: string,
				content: {
					{
						["type"]: "web_search_result",
						encrypted_content: string,
						page_age: string?,
						title: string,
						url: string,
					}
				} | {
					["type"]: "web_search_tool_result_error",
					error_code: (
						"invalid_tool_input"
						| "unavailable"
						| "max_uses_exceeded"
						| "too_many_requests"
						| "query_too_long"
					),
				},
			}
		)
	},
	model: string,
	stop_reason: ("end_turn" | "max_tokens" | "stop_sequence" | "tool_use" | "pause_turn" | "refusal")?,
	stop_sequence: string?,
	usage: {
		input_tokens: number,
		output_tokens: number,
		cache_creation_input_tokens: number?,
		cache_read_input_tokens: number?,
		cache_creation: { ephemeral_5m_input_tokens: number, ephemeral_1h_input_tokens: number }?,
		inference_geo: string?,
		server_tool_use: { web_search_requests: number }?,
		service_tier: ("standard" | "priority" | "batch")?,
	},
}

--[=[
    @type AnthropicMessagesResponse BaseAnthropicMessagesResponse
    @within OpenRouterTypes
    Non-streaming response from the Anthropic Messages API with OpenRouter extensions
]=]
export type AnthropicMessagesResponse = BaseAnthropicMessagesResponse

--[=[
    @type BigNumberUnion string
    @within OpenRouterTypes
    Price per million prompt tokens
]=]
export type BigNumberUnion = string

--[=[
    @type ChatCompletionFinishReason ("tool_calls" | "stop" | "length" | "content_filter" | "error")
    @within OpenRouterTypes
]=]
export type ChatCompletionFinishReason = "tool_calls" | "stop" | "length" | "content_filter" | "error"

--[=[
    @interface ChatGenerationTokenUsage
    @within OpenRouterTypes
    Token usage statistics
    
    @field completion_tokens number -- Number of tokens in the completion
    @field prompt_tokens number -- Number of tokens in the prompt
    @field total_tokens number -- Total number of tokens
    @field completion_tokens_details { reasoning_tokens: number?, audio_tokens: number?, accepted_prediction_tokens: number?, rejected_prediction_tokens: number? }? -- Detailed completion token usage
    @field prompt_tokens_details { cached_tokens: number?, cache_write_tokens: number?, audio_tokens: number?, video_tokens: number? }? -- Detailed prompt token usage
]=]
export type ChatGenerationTokenUsage = {
	completion_tokens: number,
	prompt_tokens: number,
	total_tokens: number,
	completion_tokens_details: {
		reasoning_tokens: number?,
		audio_tokens: number?,
		accepted_prediction_tokens: number?,
		rejected_prediction_tokens: number?,
	}?,
	prompt_tokens_details: {
		cached_tokens: number?,
		cache_write_tokens: number?,
		audio_tokens: number?,
		video_tokens: number?,
	}?,
}

--[=[
    @interface ChatMessageContentItemAudio
    @within OpenRouterTypes
    Audio input content part. Supported audio formats vary by provider.
    
    @field type "input_audio"
    @field input_audio { data: string, format: string }
]=]
export type ChatMessageContentItemAudio = { ["type"]: "input_audio", input_audio: { data: string, format: string } }

--[=[
    @interface ChatMessageContentItemCacheControl
    @within OpenRouterTypes
    Cache control for the content part
    
    @field type "ephemeral"
    @field ttl ("5m" | "1h")?
]=]
export type ChatMessageContentItemCacheControl = { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }

--[=[
    @interface ChatMessageContentItemImage
    @within OpenRouterTypes
    Image content part for vision models
    
    @field type "image_url"
    @field image_url { url: string, detail: ("auto" | "low" | "high")? }
]=]
export type ChatMessageContentItemImage = {
	["type"]: "image_url",
	image_url: { url: string, detail: ("auto" | "low" | "high")? },
}

--[=[
    @interface ChatMessageContentItemText
    @within OpenRouterTypes
    Text content part
    
    @field type "text"
    @field text string
    @field cache_control ChatMessageContentItemCacheControl?
]=]
export type ChatMessageContentItemText = {
	["type"]: "text",
	text: string,
	cache_control: ChatMessageContentItemCacheControl?,
}

--[=[
    @interface ChatMessageTokenLogprob
    @within OpenRouterTypes
    Token log probability information
    
    @field token string -- The token
    @field logprob number -- Log probability of the token
    @field bytes {number}? -- UTF-8 bytes of the token
    @field top_logprobs {{ token: string, logprob: number, bytes: {number}? }} -- Top alternative tokens with probabilities
]=]
export type ChatMessageTokenLogprob = {
	token: string,
	logprob: number,
	bytes: { number }?,
	top_logprobs: { { token: string, logprob: number, bytes: { number }? } },
}

--[=[
    @interface ChatMessageTokenLogprobs
    @within OpenRouterTypes
    Log probabilities for the completion
    
    @field content {ChatMessageTokenLogprob}? -- Log probabilities for content tokens
    @field refusal {ChatMessageTokenLogprob}? -- Log probabilities for refusal tokens
]=]
export type ChatMessageTokenLogprobs = { content: { ChatMessageTokenLogprob }?, refusal: { ChatMessageTokenLogprob }? }?

--[=[
    @interface ChatMessageToolCall
    @within OpenRouterTypes
    Tool call made by the assistant
    
    @field id string -- Tool call identifier
    @field type "function"
    @field function { name: string, arguments: string }
]=]
export type ChatMessageToolCall = { id: string, ["type"]: "function", ["function"]: { name: string, arguments: string } }

--[=[
    @interface ChatStreamOptions
    @within OpenRouterTypes
    Streaming configuration options
    
    @field include_usage boolean? -- @deprecated; Deprecated: This field has no effect. Full usage details are always included.; (Ex: true)
]=]
export type ChatStreamOptions = { include_usage: boolean? }?

--[=[
    @interface ChatStreamingMessageToolCall
    @within OpenRouterTypes
    Tool call delta for streaming responses
    
    @field index number -- Tool call index in the array; (Ex: 0)
    @field id string? -- Tool call identifier; (Ex: "call_abc123")
    @field type "function"? -- Tool call type; (Ex: "function")
    @field function { name: string?, arguments: string? }? -- Function call details
]=]
export type ChatStreamingMessageToolCall = {
	index: number,
	id: string?,
	["type"]: "function"?,
	["function"]: { name: string?, arguments: string? }?,
}

--[=[
    @interface CreateChargeRequest
    @within OpenRouterTypes
    Create a Coinbase charge for crypto payment
    
    @field amount number
    @field sender string
    @field chain_id number
]=]
export type CreateChargeRequest = { amount: number, sender: string, chain_id: number }

--[=[
    @type DataCollection ("deny" | "allow")?
    @within OpenRouterTypes
    Data collection setting. If no available model provider meets the requirement, your request will return an error.
    - allow: (default) allow providers which store user data non-transiently and may train on it
    
    - deny: use only providers which do not collect user data.
]=]
export type DataCollection = ("deny" | "allow")?

--[=[
    @interface DebugOptions
    @within OpenRouterTypes
    Debug options for inspecting request transformations (streaming only)
    
    @field echo_upstream_body boolean? -- If true, includes the transformed upstream request body in a debug chunk at the start of the stream. Only works with streaming mode.; (Ex: true)
]=]
export type DebugOptions = { echo_upstream_body: boolean? }

--[=[
    @interface DefaultParameters
    @within OpenRouterTypes
    Default parameters for this model
    
    @field temperature number? -- Range: 0.0-2.0
    @field top_p number? -- Range: 0.0-1.0
    @field frequency_penalty number? -- Range: -2.0-2.0
]=]
export type DefaultParameters = { temperature: number?, top_p: number?, frequency_penalty: number? }?

--[=[
    @interface DeveloperMessage
    @within OpenRouterTypes
    Developer message
    
    @field role "developer"
    @field content (string | {ChatMessageContentItemText}) -- Developer message content; (Ex: "This is a message from the developer.")
    @field name string? -- Optional name for the developer message; (Ex: "Developer")
]=]
export type DeveloperMessage = { role: "developer", content: string | { ChatMessageContentItemText }, name: string? }

--[=[
    @interface EdgeNetworkTimeoutResponseErrorData
    @within OpenRouterTypes
    Error data for EdgeNetworkTimeoutResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type EdgeNetworkTimeoutResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface EdgeNetworkTimeoutResponse
    @within OpenRouterTypes
    Infrastructure Timeout - Provider request timed out at edge network
    
    @field error EdgeNetworkTimeoutResponseErrorData
    @field user_id string?
]=]
export type EdgeNetworkTimeoutResponse = { error: EdgeNetworkTimeoutResponseErrorData, user_id: string? }

--[=[
    @type EndpointStatus number
    @within OpenRouterTypes
]=]
export type EndpointStatus = number

--[=[
    @interface FileCitation
    @within OpenRouterTypes
    
    @field type "file_citation"
    @field file_id string
    @field filename string
    @field index number
]=]
export type FileCitation = { ["type"]: "file_citation", file_id: string, filename: string, index: number }

--[=[
    @interface FilePath
    @within OpenRouterTypes
    
    @field type "file_path"
    @field file_id string
    @field index number
]=]
export type FilePath = { ["type"]: "file_path", file_id: string, index: number }

--[=[
    @interface ForbiddenResponseErrorData
    @within OpenRouterTypes
    Error data for ForbiddenResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type ForbiddenResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface ForbiddenResponse
    @within OpenRouterTypes
    Forbidden - Authentication successful but insufficient permissions
    
    @field error ForbiddenResponseErrorData
    @field user_id string?
]=]
export type ForbiddenResponse = { error: ForbiddenResponseErrorData, user_id: string? }

--[=[
    @type ImageGenerationStatus ("in_progress" | "completed" | "generating" | "failed")
    @within OpenRouterTypes
]=]
export type ImageGenerationStatus = "in_progress" | "completed" | "generating" | "failed"

--[=[
    @type InputModality ("text" | "image" | "file" | "audio" | "video")
    @within OpenRouterTypes
]=]
export type InputModality = "text" | "image" | "file" | "audio" | "video"

--[=[
    @type InstructType ("none" | "airoboros" | "alpaca" | "alpaca-modif" | "chatml" | "claude" | "code-llama" | "gemma" | "llama2" | "llama3" | "mistral" | "nemotron" | "neural" | "openchat" | "phi3" | "rwkv" | "vicuna" | "zephyr" | "deepseek-r1" | "deepseek-v3.1" | "qwq" | "qwen3")?
    @within OpenRouterTypes
    Instruction format type
]=]
export type InstructType = (
	"none"
	| "airoboros"
	| "alpaca"
	| "alpaca-modif"
	| "chatml"
	| "claude"
	| "code-llama"
	| "gemma"
	| "llama2"
	| "llama3"
	| "mistral"
	| "nemotron"
	| "neural"
	| "openchat"
	| "phi3"
	| "rwkv"
	| "vicuna"
	| "zephyr"
	| "deepseek-r1"
	| "deepseek-v3.1"
	| "qwq"
	| "qwen3"
)?

--[=[
    @interface InternalServerResponseErrorData
    @within OpenRouterTypes
    Error data for InternalServerResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type InternalServerResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface InternalServerResponse
    @within OpenRouterTypes
    Internal Server Error - Unexpected server error
    
    @field error InternalServerResponseErrorData
    @field user_id string?
]=]
export type InternalServerResponse = { error: InternalServerResponseErrorData, user_id: string? }

--[=[
    @interface JSONSchemaConfig
    @within OpenRouterTypes
    JSON Schema configuration object
    
    @field name string -- Schema name (a-z, A-Z, 0-9, underscores, dashes, max 64 chars); (Ex: "math_response")
    @field description string? -- Schema description for the model; (Ex: "A mathematical response")
    @field schema { [string]: any? }? -- JSON Schema object; (Ex: {"type":"object","properties":{"answer":{"type":"number"}},"required":["answer"]})
    @field strict boolean? -- Enable strict schema adherence; (Ex: false)
]=]
export type JSONSchemaConfig = { name: string, description: string?, schema: { [string]: any? }?, strict: boolean? }

--[=[
    @type ModelGroup ("Router" | "Media" | "Other" | "GPT" | "Claude" | "Gemini" | "Grok" | "Cohere" | "Nova" | "Qwen" | "Yi" | "DeepSeek" | "Mistral" | "Llama2" | "Llama3" | "Llama4" | "PaLM" | "RWKV" | "Qwen3")
    @within OpenRouterTypes
    Tokenizer type used by the model
]=]
export type ModelGroup = (
	"Router"
	| "Media"
	| "Other"
	| "GPT"
	| "Claude"
	| "Gemini"
	| "Grok"
	| "Cohere"
	| "Nova"
	| "Qwen"
	| "Yi"
	| "DeepSeek"
	| "Mistral"
	| "Llama2"
	| "Llama3"
	| "Llama4"
	| "PaLM"
	| "RWKV"
	| "Qwen3"
)

--[=[
    @type ModelName string
    @within OpenRouterTypes
    Model to use for completion
]=]
export type ModelName = string

--[=[
    @type ModelNames {ModelName}
    @within OpenRouterTypes
    Models to use for completion
]=]
export type ModelNames = { ModelName }

--[=[
    @interface ModelsCountResponse
    @within OpenRouterTypes
    Model count data
    
    @field data { count: number } -- Model count data; (Ex: {"count":150})
]=]
export type ModelsCountResponse = { data: { count: number } }

--[=[
    @interface NamedToolChoice
    @within OpenRouterTypes
    Named tool choice for specific function
    
    @field type "function"
    @field function { name: string }
]=]
export type NamedToolChoice = { ["type"]: "function", ["function"]: { name: string } }

--[=[
    @interface NotFoundResponseErrorData
    @within OpenRouterTypes
    Error data for NotFoundResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type NotFoundResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface NotFoundResponse
    @within OpenRouterTypes
    Not Found - Resource does not exist
    
    @field error NotFoundResponseErrorData
    @field user_id string?
]=]
export type NotFoundResponse = { error: NotFoundResponseErrorData, user_id: string? }

--[=[
    @interface OpenAIResponsesErrorEvent
    @within OpenRouterTypes
    Event emitted when an error occurs during streaming
    
    @field type "error"
    @field code string?
    @field message string
    @field param string?
    @field sequence_number number
]=]
export type OpenAIResponsesErrorEvent = {
	["type"]: "error",
	code: string?,
	message: string,
	param: string?,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesImageGenCallCompleted
    @within OpenRouterTypes
    
    @field type "response.image_generation_call.completed"
    @field item_id string
    @field output_index number
    @field sequence_number number
]=]
export type OpenAIResponsesImageGenCallCompleted = {
	["type"]: "response.image_generation_call.completed",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesImageGenCallGenerating
    @within OpenRouterTypes
    
    @field type "response.image_generation_call.generating"
    @field item_id string
    @field output_index number
    @field sequence_number number
]=]
export type OpenAIResponsesImageGenCallGenerating = {
	["type"]: "response.image_generation_call.generating",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesImageGenCallInProgress
    @within OpenRouterTypes
    
    @field type "response.image_generation_call.in_progress"
    @field item_id string
    @field output_index number
    @field sequence_number number
]=]
export type OpenAIResponsesImageGenCallInProgress = {
	["type"]: "response.image_generation_call.in_progress",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesImageGenCallPartialImage
    @within OpenRouterTypes
    
    @field type "response.image_generation_call.partial_image"
    @field item_id string
    @field output_index number
    @field sequence_number number
    @field partial_image_b64 string
    @field partial_image_index number
]=]
export type OpenAIResponsesImageGenCallPartialImage = {
	["type"]: "response.image_generation_call.partial_image",
	item_id: string,
	output_index: number,
	sequence_number: number,
	partial_image_b64: string,
	partial_image_index: number,
}

--[=[
    @type OpenAIResponsesIncludable ("file_search_call.results" | "message.input_image.image_url" | "computer_call_output.output.image_url" | "reasoning.encrypted_content" | "code_interpreter_call.outputs")
    @within OpenRouterTypes
]=]
export type OpenAIResponsesIncludable = (
	"file_search_call.results"
	| "message.input_image.image_url"
	| "computer_call_output.output.image_url"
	| "reasoning.encrypted_content"
	| "code_interpreter_call.outputs"
)

--[=[
    @interface OpenAIResponsesIncompleteDetails
    @within OpenRouterTypes
    
    @field reason ("max_output_tokens" | "content_filter")?
]=]
export type OpenAIResponsesIncompleteDetails = { reason: ("max_output_tokens" | "content_filter")? }?

--[=[
    @interface OpenAIResponsesReasoningDeltaEvent
    @within OpenRouterTypes
    Event emitted when reasoning text delta is streamed
    
    @field type "response.reasoning_text.delta"
    @field output_index number
    @field item_id string
    @field content_index number
    @field delta string
    @field sequence_number number
]=]
export type OpenAIResponsesReasoningDeltaEvent = {
	["type"]: "response.reasoning_text.delta",
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesReasoningDoneEvent
    @within OpenRouterTypes
    Event emitted when reasoning text streaming is complete
    
    @field type "response.reasoning_text.done"
    @field output_index number
    @field item_id string
    @field content_index number
    @field text string
    @field sequence_number number
]=]
export type OpenAIResponsesReasoningDoneEvent = {
	["type"]: "response.reasoning_text.done",
	output_index: number,
	item_id: string,
	content_index: number,
	text: string,
	sequence_number: number,
}

--[=[
    @type OpenAIResponsesReasoningEffort ("xhigh" | "high" | "medium" | "low" | "minimal" | "none")?
    @within OpenRouterTypes
]=]
export type OpenAIResponsesReasoningEffort = ("xhigh" | "high" | "medium" | "low" | "minimal" | "none")?

--[=[
    @interface OpenAIResponsesReasoningSummaryTextDeltaEvent
    @within OpenRouterTypes
    Event emitted when reasoning summary text delta is streamed
    
    @field type "response.reasoning_summary_text.delta"
    @field item_id string
    @field output_index number
    @field summary_index number
    @field delta string
    @field sequence_number number
]=]
export type OpenAIResponsesReasoningSummaryTextDeltaEvent = {
	["type"]: "response.reasoning_summary_text.delta",
	item_id: string,
	output_index: number,
	summary_index: number,
	delta: string,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesReasoningSummaryTextDoneEvent
    @within OpenRouterTypes
    Event emitted when reasoning summary text streaming is complete
    
    @field type "response.reasoning_summary_text.done"
    @field item_id string
    @field output_index number
    @field summary_index number
    @field text string
    @field sequence_number number
]=]
export type OpenAIResponsesReasoningSummaryTextDoneEvent = {
	["type"]: "response.reasoning_summary_text.done",
	item_id: string,
	output_index: number,
	summary_index: number,
	text: string,
	sequence_number: number,
}

--[=[
    @interface OpenAIResponsesRefusalContent
    @within OpenRouterTypes
    
    @field type "refusal"
    @field refusal string
]=]
export type OpenAIResponsesRefusalContent = { ["type"]: "refusal", refusal: string }

--[=[
    @type OpenAIResponsesResponseStatus ("completed" | "incomplete" | "in_progress" | "failed" | "cancelled" | "queued")
    @within OpenRouterTypes
]=]
export type OpenAIResponsesResponseStatus = (
	"completed" | "incomplete" | "in_progress" | "failed" | "cancelled" | "queued"
)

--[=[
    @type OpenAIResponsesServiceTier ("auto" | "default" | "flex" | "priority" | "scale")?
    @within OpenRouterTypes
]=]
export type OpenAIResponsesServiceTier = ("auto" | "default" | "flex" | "priority" | "scale")?

--[=[
    @type OpenAIResponsesToolChoice ("auto" | "none" | "required" | { ["type"]: "function", name: string } | { ["type"]: ("web_search_preview_2025_03_11" | "web_search_preview") })
    @within OpenRouterTypes
]=]
export type OpenAIResponsesToolChoice = "auto" | "none" | "required" | { ["type"]: "function", name: string } | {
	["type"]: "web_search_preview_2025_03_11" | "web_search_preview",
}

--[=[
    @type OpenAIResponsesTruncation ("auto" | "disabled")?
    @within OpenRouterTypes
]=]
export type OpenAIResponsesTruncation = ("auto" | "disabled")?

--[=[
    @interface OpenAIResponsesUsage
    @within OpenRouterTypes
    
    @field input_tokens number
    @field input_tokens_details { cached_tokens: number }
    @field output_tokens number
    @field output_tokens_details { reasoning_tokens: number }
    @field total_tokens number
]=]
export type OpenAIResponsesUsage = {
	input_tokens: number,
	input_tokens_details: { cached_tokens: number },
	output_tokens: number,
	output_tokens_details: { reasoning_tokens: number },
	total_tokens: number,
}

--[=[
    @type OpenResponsesErrorEvent OpenAIResponsesErrorEvent
    @within OpenRouterTypes
    Event emitted when an error occurs during streaming
]=]
export type OpenResponsesErrorEvent = OpenAIResponsesErrorEvent

--[=[
    @interface OpenResponsesFunctionCallArgumentsDeltaEvent
    @within OpenRouterTypes
    Event emitted when function call arguments are being streamed
    
    @field type "response.function_call_arguments.delta"
    @field item_id string
    @field output_index number
    @field delta string
    @field sequence_number number
]=]
export type OpenResponsesFunctionCallArgumentsDeltaEvent = {
	["type"]: "response.function_call_arguments.delta",
	item_id: string,
	output_index: number,
	delta: string,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesFunctionCallArgumentsDoneEvent
    @within OpenRouterTypes
    Event emitted when function call arguments streaming is complete
    
    @field type "response.function_call_arguments.done"
    @field item_id string
    @field output_index number
    @field name string
    @field arguments string
    @field sequence_number number
]=]
export type OpenResponsesFunctionCallArgumentsDoneEvent = {
	["type"]: "response.function_call_arguments.done",
	item_id: string,
	output_index: number,
	name: string,
	arguments: string,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesFunctionTool
    @within OpenRouterTypes
    Function tool definition
    
    @field type "function"
    @field name string
    @field description string?
    @field strict boolean?
    @field parameters { [string]: any? }?
]=]
export type OpenResponsesFunctionTool = {
	["type"]: "function",
	name: string,
	description: string?,
	strict: boolean?,
	parameters: { [string]: any? }?,
}

--[=[
    @type OpenResponsesImageGenCallCompleted OpenAIResponsesImageGenCallCompleted
    @within OpenRouterTypes
    Image generation call completed
]=]
export type OpenResponsesImageGenCallCompleted = OpenAIResponsesImageGenCallCompleted

--[=[
    @type OpenResponsesImageGenCallGenerating OpenAIResponsesImageGenCallGenerating
    @within OpenRouterTypes
    Image generation call is generating
]=]
export type OpenResponsesImageGenCallGenerating = OpenAIResponsesImageGenCallGenerating

--[=[
    @type OpenResponsesImageGenCallInProgress OpenAIResponsesImageGenCallInProgress
    @within OpenRouterTypes
    Image generation call in progress
]=]
export type OpenResponsesImageGenCallInProgress = OpenAIResponsesImageGenCallInProgress

--[=[
    @type OpenResponsesImageGenCallPartialImage OpenAIResponsesImageGenCallPartialImage
    @within OpenRouterTypes
    Image generation call with partial image
]=]
export type OpenResponsesImageGenCallPartialImage = OpenAIResponsesImageGenCallPartialImage

--[=[
    @type OpenResponsesReasoningDeltaEvent OpenAIResponsesReasoningDeltaEvent
    @within OpenRouterTypes
    Event emitted when reasoning text delta is streamed
]=]
export type OpenResponsesReasoningDeltaEvent = OpenAIResponsesReasoningDeltaEvent

--[=[
    @type OpenResponsesReasoningDoneEvent OpenAIResponsesReasoningDoneEvent
    @within OpenRouterTypes
    Event emitted when reasoning text streaming is complete
]=]
export type OpenResponsesReasoningDoneEvent = OpenAIResponsesReasoningDoneEvent

--[=[
    @type OpenResponsesReasoningSummaryTextDeltaEvent OpenAIResponsesReasoningSummaryTextDeltaEvent
    @within OpenRouterTypes
    Event emitted when reasoning summary text delta is streamed
]=]
export type OpenResponsesReasoningSummaryTextDeltaEvent = OpenAIResponsesReasoningSummaryTextDeltaEvent

--[=[
    @type OpenResponsesReasoningSummaryTextDoneEvent OpenAIResponsesReasoningSummaryTextDoneEvent
    @within OpenRouterTypes
    Event emitted when reasoning summary text streaming is complete
]=]
export type OpenResponsesReasoningSummaryTextDoneEvent = OpenAIResponsesReasoningSummaryTextDoneEvent

--[=[
    @interface OpenResponsesRefusalDeltaEvent
    @within OpenRouterTypes
    Event emitted when a refusal delta is streamed
    
    @field type "response.refusal.delta"
    @field output_index number
    @field item_id string
    @field content_index number
    @field delta string
    @field sequence_number number
]=]
export type OpenResponsesRefusalDeltaEvent = {
	["type"]: "response.refusal.delta",
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesRefusalDoneEvent
    @within OpenRouterTypes
    Event emitted when refusal streaming is complete
    
    @field type "response.refusal.done"
    @field output_index number
    @field item_id string
    @field content_index number
    @field refusal string
    @field sequence_number number
]=]
export type OpenResponsesRefusalDoneEvent = {
	["type"]: "response.refusal.done",
	output_index: number,
	item_id: string,
	content_index: number,
	refusal: string,
	sequence_number: number,
}

--[=[
    @type OpenResponsesRequestMetadata { [string]: string }?
    @within OpenRouterTypes
    Metadata key-value pairs for the request. Keys must be ≤64 characters and cannot contain brackets. Values must be ≤512 characters. Maximum 16 pairs allowed.
]=]
export type OpenResponsesRequestMetadata = { [string]: string }?

--[=[
    @interface OpenResponsesTopLogprobs
    @within OpenRouterTypes
    Alternative token with its log probability
    
    @field token string?
    @field logprob number?
]=]
export type OpenResponsesTopLogprobs = { token: string?, logprob: number? }

--[=[
    @interface OpenResponsesLogProbs
    @within OpenRouterTypes
    Log probability information for a token
    
    @field logprob number
    @field token string
    @field top_logprobs {OpenResponsesTopLogprobs}?
]=]
export type OpenResponsesLogProbs = { logprob: number, token: string, top_logprobs: { OpenResponsesTopLogprobs }? }

--[=[
    @interface OpenResponsesTextDeltaEvent
    @within OpenRouterTypes
    Event emitted when a text delta is streamed
    
    @field type "response.output_text.delta"
    @field logprobs {OpenResponsesLogProbs}
    @field output_index number
    @field item_id string
    @field content_index number
    @field delta string
    @field sequence_number number
]=]
export type OpenResponsesTextDeltaEvent = {
	["type"]: "response.output_text.delta",
	logprobs: { OpenResponsesLogProbs },
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesTextDoneEvent
    @within OpenRouterTypes
    Event emitted when text streaming is complete
    
    @field type "response.output_text.done"
    @field output_index number
    @field item_id string
    @field content_index number
    @field text string
    @field sequence_number number
    @field logprobs {OpenResponsesLogProbs}
]=]
export type OpenResponsesTextDoneEvent = {
	["type"]: "response.output_text.done",
	output_index: number,
	item_id: string,
	content_index: number,
	text: string,
	sequence_number: number,
	logprobs: { OpenResponsesLogProbs },
}

--[=[
    @type OpenResponsesUsage (OpenAIResponsesUsage & { cost: number?, is_byok: boolean?, cost_details: { upstream_inference_cost: number?, upstream_inference_input_cost: number, upstream_inference_output_cost: number }? })
    @within OpenRouterTypes
    Token usage information for the response
]=]
export type OpenResponsesUsage = OpenAIResponsesUsage & {
	cost: number?,
	is_byok: boolean?,
	cost_details: {
		upstream_inference_cost: number?,
		upstream_inference_input_cost: number,
		upstream_inference_output_cost: number,
	}?,
}

--[=[
    @interface OpenRouterAnthropicMessageParam
    @within OpenRouterTypes
    Anthropic message with OpenRouter extensions
    
    @field role ("user" | "assistant")
    @field content (string | {({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "image", source: ({ ["type"]: "base64", media_type: ("image/jpeg" | "image/png" | "image/gif" | "image/webp"), data: string } | { ["type"]: "url", url: string }), cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "document", source: ({ ["type"]: "base64", media_type: "application/pdf", data: string } | { ["type"]: "text", media_type: "text/plain", data: string } | { ["type"]: "content", content: (string | {({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "image", source: ({ ["type"]: "base64", media_type: ("image/jpeg" | "image/png" | "image/gif" | "image/webp"), data: string } | { ["type"]: "url", url: string }), cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? })}) } | { ["type"]: "url", url: string }), citations: { enabled: boolean? }?, context: string?, title: string?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "tool_use", id: string, name: string, input: any?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "tool_result", tool_use_id: string, content: (string | {({ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "image", source: ({ ["type"]: "base64", media_type: ("image/jpeg" | "image/png" | "image/gif" | "image/webp"), data: string } | { ["type"]: "url", url: string }), cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? })})?, is_error: boolean?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "thinking", thinking: string, signature: string } | { ["type"]: "redacted_thinking", data: string } | { ["type"]: "server_tool_use", id: string, name: "web_search", input: any?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "web_search_tool_result", tool_use_id: string, content: ({{ ["type"]: "web_search_result", encrypted_content: string, title: string, url: string, page_age: string? }} | { ["type"]: "web_search_tool_result_error", error_code: ("invalid_tool_input" | "unavailable" | "max_uses_exceeded" | "too_many_requests" | "query_too_long") }), cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "search_result", source: string, title: string, content: {{ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? }}, citations: { enabled: boolean? }?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? })})
]=]
export type OpenRouterAnthropicMessageParam = {
	role: "user" | "assistant",
	content: string | {
		(
			{
				["type"]: "text",
				text: string,
				citations: {
					{
						["type"]: "char_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_char_index: number,
						end_char_index: number,
					} | {
						["type"]: "page_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_page_number: number,
						end_page_number: number,
					} | {
						["type"]: "content_block_location",
						cited_text: string,
						document_index: number,
						document_title: string?,
						start_block_index: number,
						end_block_index: number,
					} | {
						["type"]: "web_search_result_location",
						cited_text: string,
						encrypted_index: string,
						title: string?,
						url: string,
					} | {
						["type"]: "search_result_location",
						cited_text: string,
						search_result_index: number,
						source: string,
						title: string?,
						start_block_index: number,
						end_block_index: number,
					}
				}?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "image",
				source: {
					["type"]: "base64",
					media_type: "image/jpeg" | "image/png" | "image/gif" | "image/webp",
					data: string,
				} | { ["type"]: "url", url: string },
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "document",
				source: (
					{ ["type"]: "base64", media_type: "application/pdf", data: string }
					| { ["type"]: "text", media_type: "text/plain", data: string }
					| {
						["type"]: "content",
						content: string | {
							{
								["type"]: "text",
								text: string,
								citations: {
									{
										["type"]: "char_location",
										cited_text: string,
										document_index: number,
										document_title: string?,
										start_char_index: number,
										end_char_index: number,
									} | {
										["type"]: "page_location",
										cited_text: string,
										document_index: number,
										document_title: string?,
										start_page_number: number,
										end_page_number: number,
									} | {
										["type"]: "content_block_location",
										cited_text: string,
										document_index: number,
										document_title: string?,
										start_block_index: number,
										end_block_index: number,
									} | {
										["type"]: "web_search_result_location",
										cited_text: string,
										encrypted_index: string,
										title: string?,
										url: string,
									} | {
										["type"]: "search_result_location",
										cited_text: string,
										search_result_index: number,
										source: string,
										title: string?,
										start_block_index: number,
										end_block_index: number,
									}
								}?,
								cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
							} | {
								["type"]: "image",
								source: {
									["type"]: "base64",
									media_type: "image/jpeg" | "image/png" | "image/gif" | "image/webp",
									data: string,
								} | { ["type"]: "url", url: string },
								cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
							}
						},
					}
					| { ["type"]: "url", url: string }
				),
				citations: { enabled: boolean? }?,
				context: string?,
				title: string?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "tool_use",
				id: string,
				name: string,
				input: any?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "tool_result",
				tool_use_id: string,
				content: (string | {
					{
						["type"]: "text",
						text: string,
						citations: {
							{
								["type"]: "char_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_char_index: number,
								end_char_index: number,
							} | {
								["type"]: "page_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_page_number: number,
								end_page_number: number,
							} | {
								["type"]: "content_block_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_block_index: number,
								end_block_index: number,
							} | {
								["type"]: "web_search_result_location",
								cited_text: string,
								encrypted_index: string,
								title: string?,
								url: string,
							} | {
								["type"]: "search_result_location",
								cited_text: string,
								search_result_index: number,
								source: string,
								title: string?,
								start_block_index: number,
								end_block_index: number,
							}
						}?,
						cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
					} | {
						["type"]: "image",
						source: {
							["type"]: "base64",
							media_type: "image/jpeg" | "image/png" | "image/gif" | "image/webp",
							data: string,
						} | { ["type"]: "url", url: string },
						cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
					}
				})?,
				is_error: boolean?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| { ["type"]: "thinking", thinking: string, signature: string }
			| { ["type"]: "redacted_thinking", data: string }
			| {
				["type"]: "server_tool_use",
				id: string,
				name: "web_search",
				input: any?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "web_search_tool_result",
				tool_use_id: string,
				content: {
					{
						["type"]: "web_search_result",
						encrypted_content: string,
						title: string,
						url: string,
						page_age: string?,
					}
				} | {
					["type"]: "web_search_tool_result_error",
					error_code: (
						"invalid_tool_input"
						| "unavailable"
						| "max_uses_exceeded"
						| "too_many_requests"
						| "query_too_long"
					),
				},
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
			| {
				["type"]: "search_result",
				source: string,
				title: string,
				content: {
					{
						["type"]: "text",
						text: string,
						citations: {
							{
								["type"]: "char_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_char_index: number,
								end_char_index: number,
							} | {
								["type"]: "page_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_page_number: number,
								end_page_number: number,
							} | {
								["type"]: "content_block_location",
								cited_text: string,
								document_index: number,
								document_title: string?,
								start_block_index: number,
								end_block_index: number,
							} | {
								["type"]: "web_search_result_location",
								cited_text: string,
								encrypted_index: string,
								title: string?,
								url: string,
							} | {
								["type"]: "search_result_location",
								cited_text: string,
								search_result_index: number,
								source: string,
								title: string?,
								start_block_index: number,
								end_block_index: number,
							}
						}?,
						cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
					}
				},
				citations: { enabled: boolean? }?,
				cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
			}
		)
	},
}

--[=[
    @interface OutputItemFunctionCall
    @within OpenRouterTypes
    
    @field type "function_call"
    @field id string?
    @field name string
    @field arguments string
    @field call_id string
    @field status ("completed" | "incomplete" | "in_progress")?
]=]
export type OutputItemFunctionCall = {
	["type"]: "function_call",
	id: string?,
	name: string,
	arguments: string,
	call_id: string,
	status: ("completed" | "incomplete" | "in_progress")?,
}

--[=[
    @interface OutputItemImageGenerationCall
    @within OpenRouterTypes
    
    @field type "image_generation_call"
    @field id string
    @field result string?
    @field status ImageGenerationStatus
]=]
export type OutputItemImageGenerationCall = {
	["type"]: "image_generation_call",
	id: string,
	result: string?,
	status: ImageGenerationStatus,
}

--[=[
    @type OutputModality ("text" | "image" | "embeddings" | "audio")
    @within OpenRouterTypes
]=]
export type OutputModality = "text" | "image" | "embeddings" | "audio"

--[=[
    @interface ModelArchitecture
    @within OpenRouterTypes
    Model architecture information
    
    @field tokenizer ModelGroup?
    @field instruct_type ("none" | "airoboros" | "alpaca" | "alpaca-modif" | "chatml" | "claude" | "code-llama" | "gemma" | "llama2" | "llama3" | "mistral" | "nemotron" | "neural" | "openchat" | "phi3" | "rwkv" | "vicuna" | "zephyr" | "deepseek-r1" | "deepseek-v3.1" | "qwq" | "qwen3")? -- Instruction format type; (Ex: "chatml")
    @field modality string? -- Primary modality of the model; (Ex: "text->text")
    @field input_modalities {InputModality} -- Supported input modalities
    @field output_modalities {OutputModality} -- Supported output modalities
]=]
export type ModelArchitecture = {
	tokenizer: ModelGroup?,
	instruct_type: (
		"none"
		| "airoboros"
		| "alpaca"
		| "alpaca-modif"
		| "chatml"
		| "claude"
		| "code-llama"
		| "gemma"
		| "llama2"
		| "llama3"
		| "mistral"
		| "nemotron"
		| "neural"
		| "openchat"
		| "phi3"
		| "rwkv"
		| "vicuna"
		| "zephyr"
		| "deepseek-r1"
		| "deepseek-v3.1"
		| "qwq"
		| "qwen3"
	)?,
	modality: string?,
	input_modalities: { InputModality },
	output_modalities: { OutputModality },
}

--[=[
    @type PDFParserEngine ("mistral-ocr" | "pdf-text" | "native")
    @within OpenRouterTypes
    The engine to use for parsing PDF files.
]=]
export type PDFParserEngine = "mistral-ocr" | "pdf-text" | "native"

--[=[
    @interface PDFParserOptions
    @within OpenRouterTypes
    Options for PDF parsing.
    
    @field engine PDFParserEngine?
]=]
export type PDFParserOptions = { engine: PDFParserEngine? }

--[=[
    @type Parameter ("temperature" | "top_p" | "top_k" | "min_p" | "top_a" | "frequency_penalty" | "presence_penalty" | "repetition_penalty" | "max_tokens" | "logit_bias" | "logprobs" | "top_logprobs" | "seed" | "response_format" | "structured_outputs" | "stop" | "tools" | "tool_choice" | "parallel_tool_calls" | "include_reasoning" | "reasoning" | "reasoning_effort" | "web_search_options" | "verbosity")
    @within OpenRouterTypes
]=]
export type Parameter = (
	"temperature"
	| "top_p"
	| "top_k"
	| "min_p"
	| "top_a"
	| "frequency_penalty"
	| "presence_penalty"
	| "repetition_penalty"
	| "max_tokens"
	| "logit_bias"
	| "logprobs"
	| "top_logprobs"
	| "seed"
	| "response_format"
	| "structured_outputs"
	| "stop"
	| "tools"
	| "tool_choice"
	| "parallel_tool_calls"
	| "include_reasoning"
	| "reasoning"
	| "reasoning_effort"
	| "web_search_options"
	| "verbosity"
)

--[=[
    @interface PayloadTooLargeResponseErrorData
    @within OpenRouterTypes
    Error data for PayloadTooLargeResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type PayloadTooLargeResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface PayloadTooLargeResponse
    @within OpenRouterTypes
    Payload Too Large - Request payload exceeds size limits
    
    @field error PayloadTooLargeResponseErrorData
    @field user_id string?
]=]
export type PayloadTooLargeResponse = { error: PayloadTooLargeResponseErrorData, user_id: string? }

--[=[
    @interface PaymentRequiredResponseErrorData
    @within OpenRouterTypes
    Error data for PaymentRequiredResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type PaymentRequiredResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface PaymentRequiredResponse
    @within OpenRouterTypes
    Payment Required - Insufficient credits or quota to complete request
    
    @field error PaymentRequiredResponseErrorData
    @field user_id string?
]=]
export type PaymentRequiredResponse = { error: PaymentRequiredResponseErrorData, user_id: string? }

--[=[
    @interface PerRequestLimits
    @within OpenRouterTypes
    Per-request token limits
    
    @field prompt_tokens number -- Maximum prompt tokens per request; (Ex: 1000)
    @field completion_tokens number -- Maximum completion tokens per request; (Ex: 1000)
]=]
export type PerRequestLimits = { prompt_tokens: number, completion_tokens: number }?

--[=[
    @interface PercentileLatencyCutoffs
    @within OpenRouterTypes
    Percentile-based latency cutoffs. All specified cutoffs must be met for an endpoint to be preferred.
    
    @field p50 number? -- Maximum p50 latency (seconds)
    @field p75 number? -- Maximum p75 latency (seconds)
    @field p90 number? -- Maximum p90 latency (seconds)
    @field p99 number? -- Maximum p99 latency (seconds)
]=]
export type PercentileLatencyCutoffs = { p50: number?, p75: number?, p90: number?, p99: number? }

--[=[
    @interface PercentileStats
    @within OpenRouterTypes
    Latency percentiles in milliseconds over the last 30 minutes. Latency measures time to first token. Only visible when authenticated with an API key or cookie; returns null for unauthenticated requests.
    
    @field p50 number -- Median (50th percentile); (Ex: 25.5)
    @field p75 number -- 75th percentile; (Ex: 35.2)
    @field p90 number -- 90th percentile; (Ex: 48.7)
    @field p99 number -- 99th percentile; (Ex: 85.3)
]=]
export type PercentileStats = { p50: number, p75: number, p90: number, p99: number }?

--[=[
    @interface PercentileThroughputCutoffs
    @within OpenRouterTypes
    Percentile-based throughput cutoffs. All specified cutoffs must be met for an endpoint to be preferred.
    
    @field p50 number? -- Minimum p50 throughput (tokens/sec)
    @field p75 number? -- Minimum p75 throughput (tokens/sec)
    @field p90 number? -- Minimum p90 throughput (tokens/sec)
    @field p99 number? -- Minimum p99 throughput (tokens/sec)
]=]
export type PercentileThroughputCutoffs = { p50: number?, p75: number?, p90: number?, p99: number? }

--[=[
    @type PreferredMaxLatency (number | PercentileLatencyCutoffs)?
    @within OpenRouterTypes
    Preferred maximum latency (in seconds). Can be a number (applies to p50) or an object with percentile-specific cutoffs. Endpoints above the threshold(s) may still be used, but are deprioritized in routing. When using fallback models, this may cause a fallback model to be used instead of the primary model if it meets the threshold.
]=]
export type PreferredMaxLatency = (number | PercentileLatencyCutoffs)?

--[=[
    @type PreferredMinThroughput (number | PercentileThroughputCutoffs)?
    @within OpenRouterTypes
    Preferred minimum throughput (in tokens per second). Can be a number (applies to p50) or an object with percentile-specific cutoffs. Endpoints below the threshold(s) may still be used, but are deprioritized in routing. When using fallback models, this may cause a fallback model to be used instead of the primary model if it meets the threshold.
]=]
export type PreferredMinThroughput = (number | PercentileThroughputCutoffs)?

--[=[
    @type ProviderName ("AI21" | "AionLabs" | "Alibaba" | "Ambient" | "Amazon Bedrock" | "Amazon Nova" | "Anthropic" | "Arcee AI" | "AtlasCloud" | "Avian" | "Azure" | "BaseTen" | "BytePlus" | "Black Forest Labs" | "Cerebras" | "Chutes" | "Cirrascale" | "Clarifai" | "Cloudflare" | "Cohere" | "Crusoe" | "DeepInfra" | "DeepSeek" | "Featherless" | "Fireworks" | "Friendli" | "GMICloud" | "Google" | "Google AI Studio" | "Groq" | "Hyperbolic" | "Inception" | "Inceptron" | "InferenceNet" | "Ionstream" | "Infermatic" | "Io Net" | "Inflection" | "Liquid" | "Mara" | "Mancer 2" | "Minimax" | "ModelRun" | "Mistral" | "Modular" | "Moonshot AI" | "Morph" | "NCompass" | "Nebius" | "NextBit" | "Novita" | "Nvidia" | "OpenAI" | "OpenInference" | "Parasail" | "Perplexity" | "Phala" | "Relace" | "SambaNova" | "Seed" | "SiliconFlow" | "Sourceful" | "StepFun" | "Stealth" | "StreamLake" | "Switchpoint" | "Together" | "Upstage" | "Venice" | "WandB" | "Xiaomi" | "xAI" | "Z.AI" | "FakeProvider")
    @within OpenRouterTypes
]=]
export type ProviderName = (
	"AI21"
	| "AionLabs"
	| "Alibaba"
	| "Ambient"
	| "Amazon Bedrock"
	| "Amazon Nova"
	| "Anthropic"
	| "Arcee AI"
	| "AtlasCloud"
	| "Avian"
	| "Azure"
	| "BaseTen"
	| "BytePlus"
	| "Black Forest Labs"
	| "Cerebras"
	| "Chutes"
	| "Cirrascale"
	| "Clarifai"
	| "Cloudflare"
	| "Cohere"
	| "Crusoe"
	| "DeepInfra"
	| "DeepSeek"
	| "Featherless"
	| "Fireworks"
	| "Friendli"
	| "GMICloud"
	| "Google"
	| "Google AI Studio"
	| "Groq"
	| "Hyperbolic"
	| "Inception"
	| "Inceptron"
	| "InferenceNet"
	| "Ionstream"
	| "Infermatic"
	| "Io Net"
	| "Inflection"
	| "Liquid"
	| "Mara"
	| "Mancer 2"
	| "Minimax"
	| "ModelRun"
	| "Mistral"
	| "Modular"
	| "Moonshot AI"
	| "Morph"
	| "NCompass"
	| "Nebius"
	| "NextBit"
	| "Novita"
	| "Nvidia"
	| "OpenAI"
	| "OpenInference"
	| "Parasail"
	| "Perplexity"
	| "Phala"
	| "Relace"
	| "SambaNova"
	| "Seed"
	| "SiliconFlow"
	| "Sourceful"
	| "StepFun"
	| "Stealth"
	| "StreamLake"
	| "Switchpoint"
	| "Together"
	| "Upstage"
	| "Venice"
	| "WandB"
	| "Xiaomi"
	| "xAI"
	| "Z.AI"
	| "FakeProvider"
)

--[=[
    @interface ProviderOverloadedResponseErrorData
    @within OpenRouterTypes
    Error data for ProviderOverloadedResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type ProviderOverloadedResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface ProviderOverloadedResponse
    @within OpenRouterTypes
    Provider Overloaded - Provider is temporarily overloaded
    
    @field error ProviderOverloadedResponseErrorData
    @field user_id string?
]=]
export type ProviderOverloadedResponse = { error: ProviderOverloadedResponseErrorData, user_id: string? }

--[=[
    @type ProviderSort ("price" | "throughput" | "latency")
    @within OpenRouterTypes
    The provider sorting strategy (price, throughput, latency)
]=]
export type ProviderSort = "price" | "throughput" | "latency"

--[=[
    @interface ProviderSortConfig
    @within OpenRouterTypes
    The provider sorting strategy (price, throughput, latency)
    
    @field by ("price" | "throughput" | "latency")? -- The provider sorting strategy (price, throughput, latency); (Ex: "price")
    @field partition ("model" | "none")? -- Partitioning strategy for sorting: "model" (default) groups endpoints by model before sorting (fallback models remain fallbacks), "none" sorts all endpoints together regardless of model.; (Ex: "model")
]=]
export type ProviderSortConfig = { by: ("price" | "throughput" | "latency")?, partition: ("model" | "none")? }

--[=[
    @interface PublicPricing
    @within OpenRouterTypes
    Pricing information for the model
    
    @field prompt BigNumberUnion
    @field completion BigNumberUnion
    @field request BigNumberUnion?
    @field image BigNumberUnion?
    @field image_token BigNumberUnion?
    @field image_output BigNumberUnion?
    @field audio BigNumberUnion?
    @field audio_output BigNumberUnion?
    @field input_audio_cache BigNumberUnion?
    @field web_search BigNumberUnion?
    @field internal_reasoning BigNumberUnion?
    @field input_cache_read BigNumberUnion?
    @field input_cache_write BigNumberUnion?
    @field discount number?
]=]
export type PublicPricing = {
	prompt: BigNumberUnion,
	completion: BigNumberUnion,
	request: BigNumberUnion?,
	image: BigNumberUnion?,
	image_token: BigNumberUnion?,
	image_output: BigNumberUnion?,
	audio: BigNumberUnion?,
	audio_output: BigNumberUnion?,
	input_audio_cache: BigNumberUnion?,
	web_search: BigNumberUnion?,
	internal_reasoning: BigNumberUnion?,
	input_cache_read: BigNumberUnion?,
	input_cache_write: BigNumberUnion?,
	discount: number?,
}

--[=[
    @type Quantization ("int4" | "int8" | "fp4" | "fp6" | "fp8" | "fp16" | "bf16" | "fp32" | "unknown")
    @within OpenRouterTypes
]=]
export type Quantization = "int4" | "int8" | "fp4" | "fp6" | "fp8" | "fp16" | "bf16" | "fp32" | "unknown"

--[=[
    @interface ProviderPreferences
    @within OpenRouterTypes
    Provider routing preferences for the request.
    
    @field allow_fallbacks boolean? -- Whether to allow backup providers to serve requests; - true: (default) when the primary provider (or your custom providers in "order") is unavailable, use the next best provider.; - false: use only the primary/custom provider, and return the upstream error if it's unavailable.
    @field require_parameters boolean? -- Whether to filter providers to only those that support the parameters you've provided. If this setting is omitted or set to false, then providers will receive only the parameters they support, and ignore the rest.
    @field data_collection DataCollection?
    @field zdr boolean? -- Whether to restrict routing to only ZDR (Zero Data Retention) endpoints. When true, only endpoints that do not retain prompts will be used.; (Ex: true)
    @field enforce_distillable_text boolean? -- Whether to restrict routing to only models that allow text distillation. When true, only models where the author has allowed distillation will be used.; (Ex: true)
    @field order {(ProviderName | string)}? -- An ordered list of provider slugs. The router will attempt to use the first provider in the subset of this list that supports your requested model, and fall back to the next if it is unavailable. If no providers are available, the request will fail with an error message.
    @field only {(ProviderName | string)}? -- List of provider slugs to allow. If provided, this list is merged with your account-wide allowed provider settings for this request.
    @field ignore {(ProviderName | string)}? -- List of provider slugs to ignore. If provided, this list is merged with your account-wide ignored provider settings for this request.
    @field quantizations {Quantization}? -- A list of quantization levels to filter the provider by.
    @field sort (ProviderSort & (ProviderSort | ProviderSortConfig))?
    @field max_price { prompt: BigNumberUnion?, completion: BigNumberUnion?, image: BigNumberUnion?, audio: BigNumberUnion?, request: BigNumberUnion? }? -- The object specifying the maximum price you want to pay for this request. USD price per million tokens, for prompt and completion.
    @field preferred_min_throughput PreferredMinThroughput?
    @field preferred_max_latency PreferredMaxLatency?
]=]
export type ProviderPreferences = {
	allow_fallbacks: boolean?,
	require_parameters: boolean?,
	data_collection: DataCollection?,
	zdr: boolean?,
	enforce_distillable_text: boolean?,
	order: { ProviderName | string }?,
	only: { ProviderName | string }?,
	ignore: { ProviderName | string }?,
	quantizations: { Quantization }?,
	sort: (ProviderSort & (ProviderSort | ProviderSortConfig))?,
	max_price: {
		prompt: BigNumberUnion?,
		completion: BigNumberUnion?,
		image: BigNumberUnion?,
		audio: BigNumberUnion?,
		request: BigNumberUnion?,
	}?,
	preferred_min_throughput: PreferredMinThroughput?,
	preferred_max_latency: PreferredMaxLatency?,
}

--[=[
    @interface PublicEndpoint
    @within OpenRouterTypes
    Information about a specific model endpoint
    
    @field name string
    @field model_id string -- The unique identifier for the model (permaslug); (Ex: "openai/gpt-4")
    @field model_name string
    @field context_length number
    @field pricing { prompt: BigNumberUnion, completion: BigNumberUnion, request: BigNumberUnion?, image: BigNumberUnion?, image_token: BigNumberUnion?, image_output: BigNumberUnion?, audio: BigNumberUnion?, audio_output: BigNumberUnion?, input_audio_cache: BigNumberUnion?, web_search: BigNumberUnion?, internal_reasoning: BigNumberUnion?, input_cache_read: BigNumberUnion?, input_cache_write: BigNumberUnion?, discount: number? }
    @field provider_name ProviderName
    @field tag string
    @field quantization Quantization?
    @field max_completion_tokens number?
    @field max_prompt_tokens number?
    @field supported_parameters {Parameter}
    @field status EndpointStatus?
    @field uptime_last_30m number?
    @field supports_implicit_caching boolean
    @field latency_last_30m PercentileStats
    @field throughput_last_30m PercentileStats
]=]
export type PublicEndpoint = {
	name: string,
	model_id: string,
	model_name: string,
	context_length: number,
	pricing: {
		prompt: BigNumberUnion,
		completion: BigNumberUnion,
		request: BigNumberUnion?,
		image: BigNumberUnion?,
		image_token: BigNumberUnion?,
		image_output: BigNumberUnion?,
		audio: BigNumberUnion?,
		audio_output: BigNumberUnion?,
		input_audio_cache: BigNumberUnion?,
		web_search: BigNumberUnion?,
		internal_reasoning: BigNumberUnion?,
		input_cache_read: BigNumberUnion?,
		input_cache_write: BigNumberUnion?,
		discount: number?,
	},
	provider_name: ProviderName,
	tag: string,
	quantization: Quantization?,
	max_completion_tokens: number?,
	max_prompt_tokens: number?,
	supported_parameters: { Parameter },
	status: EndpointStatus?,
	uptime_last_30m: number?,
	supports_implicit_caching: boolean,
	latency_last_30m: PercentileStats,
	throughput_last_30m: PercentileStats,
}

--[=[
    @interface ListEndpointsResponse
    @within OpenRouterTypes
    List of available endpoints for a model
    
    @field id string -- Unique identifier for the model; (Ex: "openai/gpt-4")
    @field name string -- Display name of the model; (Ex: "GPT-4")
    @field created number -- Unix timestamp of when the model was created; (Ex: 1692901234)
    @field description string -- Description of the model; (Ex: "GPT-4 is a large multimodal model that can solve difficult problems with greater accuracy.")
    @field architecture (ModelArchitecture & { tokenizer: ModelGroup?, instruct_type: InstructType, modality: string?, input_modalities: {InputModality}, output_modalities: {OutputModality} })
    @field endpoints {PublicEndpoint} -- List of available endpoints for this model
]=]
export type ListEndpointsResponse = {
	id: string,
	name: string,
	created: number,
	description: string,
	architecture: ModelArchitecture & {
		tokenizer: ModelGroup?,
		instruct_type: InstructType,
		modality: string?,
		input_modalities: { InputModality },
		output_modalities: { OutputModality },
	},
	endpoints: { PublicEndpoint },
}

--[=[
    @interface ReasoningDetailEncrypted
    @within OpenRouterTypes
    Reasoning detail encrypted schema
    
    @field type "reasoning.encrypted"
    @field data string
    @field id string?
    @field format ("unknown" | "openai-responses-v1" | "azure-openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1" | "google-gemini-v1")?
    @field index number?
]=]
export type ReasoningDetailEncrypted = {
	["type"]: "reasoning.encrypted",
	data: string,
	id: string?,
	format: (
		"unknown"
		| "openai-responses-v1"
		| "azure-openai-responses-v1"
		| "xai-responses-v1"
		| "anthropic-claude-v1"
		| "google-gemini-v1"
	)?,
	index: number?,
}

--[=[
    @interface ReasoningDetailSummary
    @within OpenRouterTypes
    Reasoning detail summary schema
    
    @field type "reasoning.summary"
    @field summary string
    @field id string?
    @field format ("unknown" | "openai-responses-v1" | "azure-openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1" | "google-gemini-v1")?
    @field index number?
]=]
export type ReasoningDetailSummary = {
	["type"]: "reasoning.summary",
	summary: string,
	id: string?,
	format: (
		"unknown"
		| "openai-responses-v1"
		| "azure-openai-responses-v1"
		| "xai-responses-v1"
		| "anthropic-claude-v1"
		| "google-gemini-v1"
	)?,
	index: number?,
}

--[=[
    @interface ReasoningDetailText
    @within OpenRouterTypes
    Reasoning detail text schema
    
    @field type "reasoning.text"
    @field text string?
    @field signature string?
    @field id string?
    @field format ("unknown" | "openai-responses-v1" | "azure-openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1" | "google-gemini-v1")?
    @field index number?
]=]
export type ReasoningDetailText = {
	["type"]: "reasoning.text",
	text: string?,
	signature: string?,
	id: string?,
	format: (
		"unknown"
		| "openai-responses-v1"
		| "azure-openai-responses-v1"
		| "xai-responses-v1"
		| "anthropic-claude-v1"
		| "google-gemini-v1"
	)?,
	index: number?,
}

--[=[
    @type ReasoningDetailUnion (ReasoningDetailSummary | ReasoningDetailEncrypted | ReasoningDetailText)
    @within OpenRouterTypes
    Reasoning detail union schema
]=]
export type ReasoningDetailUnion = ReasoningDetailSummary | ReasoningDetailEncrypted | ReasoningDetailText

--[=[
    @type AssistantMessageReasoningDetails {ReasoningDetailUnion}
    @within OpenRouterTypes
    Reasoning details for extended thinking models
]=]
export type AssistantMessageReasoningDetails = { ReasoningDetailUnion }

--[=[
    @interface ChatStreamingMessageChunk
    @within OpenRouterTypes
    Delta changes in streaming response
    
    @field role "assistant"? -- The role of the message author; (Ex: "assistant")
    @field content string? -- Message content delta; (Ex: "Hello")
    @field reasoning string? -- Reasoning content delta; (Ex: "I need to")
    @field refusal string? -- Refusal message delta
    @field tool_calls {ChatStreamingMessageToolCall}? -- Tool calls delta
    @field reasoning_details AssistantMessageReasoningDetails?
]=]
export type ChatStreamingMessageChunk = {
	role: "assistant"?,
	content: string?,
	reasoning: string?,
	refusal: string?,
	tool_calls: { ChatStreamingMessageToolCall }?,
	reasoning_details: AssistantMessageReasoningDetails?,
}

--[=[
    @interface ChatStreamingChoice
    @within OpenRouterTypes
    Streaming completion choice chunk
    
    @field delta ChatStreamingMessageChunk
    @field finish_reason ChatCompletionFinishReason?
    @field index number -- Choice index; (Ex: 0)
    @field logprobs ChatMessageTokenLogprobs?
]=]
export type ChatStreamingChoice = {
	delta: ChatStreamingMessageChunk,
	finish_reason: ChatCompletionFinishReason?,
	index: number,
	logprobs: ChatMessageTokenLogprobs?,
}

--[=[
    @interface ChatStreamingResponseChunk
    @within OpenRouterTypes
    Streaming chat completion chunk
    
    @field id string -- Unique chunk identifier; (Ex: "chatcmpl-123")
    @field choices {ChatStreamingChoice} -- List of streaming chunk choices
    @field created number -- Unix timestamp of creation; (Ex: 1677652288)
    @field model string -- Model used for completion; (Ex: "openai/gpt-4")
    @field object "chat.completion.chunk"
    @field system_fingerprint string? -- System fingerprint; (Ex: "fp_44709d6fcb")
    @field error { message: string, code: number }? -- Error information; (Ex: {"message":"Rate limit exceeded","code":429})
    @field usage ChatGenerationTokenUsage?
]=]
export type ChatStreamingResponseChunk = {
	id: string,
	choices: { ChatStreamingChoice },
	created: number,
	model: string,
	object: "chat.completion.chunk",
	system_fingerprint: string?,
	error: { message: string, code: number }?,
	usage: ChatGenerationTokenUsage?,
}

--[=[
    @interface ReasoningSummaryText
    @within OpenRouterTypes
    
    @field type "summary_text"
    @field text string
]=]
export type ReasoningSummaryText = { ["type"]: "summary_text", text: string }

--[=[
    @interface OpenAIResponsesReasoningSummaryPartAddedEvent
    @within OpenRouterTypes
    Event emitted when a reasoning summary part is added
    
    @field type "response.reasoning_summary_part.added"
    @field output_index number
    @field item_id string
    @field summary_index number
    @field part ReasoningSummaryText
    @field sequence_number number
]=]
export type OpenAIResponsesReasoningSummaryPartAddedEvent = {
	["type"]: "response.reasoning_summary_part.added",
	output_index: number,
	item_id: string,
	summary_index: number,
	part: ReasoningSummaryText,
	sequence_number: number,
}

--[=[
    @type OpenResponsesReasoningSummaryPartAddedEvent OpenAIResponsesReasoningSummaryPartAddedEvent
    @within OpenRouterTypes
    Event emitted when a reasoning summary part is added
]=]
export type OpenResponsesReasoningSummaryPartAddedEvent = OpenAIResponsesReasoningSummaryPartAddedEvent

--[=[
    @interface OpenResponsesReasoningSummaryPartDoneEvent
    @within OpenRouterTypes
    Event emitted when a reasoning summary part is complete
    
    @field type "response.reasoning_summary_part.done"
    @field output_index number
    @field item_id string
    @field summary_index number
    @field part ReasoningSummaryText
    @field sequence_number number
]=]
export type OpenResponsesReasoningSummaryPartDoneEvent = {
	["type"]: "response.reasoning_summary_part.done",
	output_index: number,
	item_id: string,
	summary_index: number,
	part: ReasoningSummaryText,
	sequence_number: number,
}

--[=[
    @type ReasoningSummaryVerbosity ("auto" | "concise" | "detailed")?
    @within OpenRouterTypes
]=]
export type ReasoningSummaryVerbosity = ("auto" | "concise" | "detailed")?

--[=[
    @interface OpenAIResponsesReasoningConfig
    @within OpenRouterTypes
    
    @field effort OpenAIResponsesReasoningEffort?
    @field summary ReasoningSummaryVerbosity?
]=]
export type OpenAIResponsesReasoningConfig = {
	effort: OpenAIResponsesReasoningEffort?,
	summary: ReasoningSummaryVerbosity?,
}?

--[=[
    @type OpenResponsesReasoningConfig (OpenAIResponsesReasoningConfig & { max_tokens: number?, enabled: boolean? })
    @within OpenRouterTypes
    Configuration for reasoning mode in the response
]=]
export type OpenResponsesReasoningConfig = OpenAIResponsesReasoningConfig & { max_tokens: number?, enabled: boolean? }

--[=[
    @interface ReasoningTextContent
    @within OpenRouterTypes
    
    @field type "reasoning_text"
    @field text string
]=]
export type ReasoningTextContent = { ["type"]: "reasoning_text", text: string }

--[=[
    @interface OutputItemReasoning
    @within OpenRouterTypes
    
    @field type "reasoning"
    @field id string
    @field content {ReasoningTextContent}?
    @field summary {ReasoningSummaryText}
    @field encrypted_content string?
    @field status ("completed" | "incomplete" | "in_progress")?
]=]
export type OutputItemReasoning = {
	["type"]: "reasoning",
	id: string,
	content: { ReasoningTextContent }?,
	summary: { ReasoningSummaryText },
	encrypted_content: string?,
	status: ("completed" | "incomplete" | "in_progress")?,
}

--[=[
    @type OpenResponsesReasoning (OutputItemReasoning & { content: {ReasoningTextContent}?, signature: string?, format: ("unknown" | "openai-responses-v1" | "azure-openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1" | "google-gemini-v1")? })
    @within OpenRouterTypes
    Reasoning output item with signature and format extensions
]=]
export type OpenResponsesReasoning = OutputItemReasoning & {
	content: { ReasoningTextContent }?,
	signature: string?,
	format: (
		"unknown"
		| "openai-responses-v1"
		| "azure-openai-responses-v1"
		| "xai-responses-v1"
		| "anthropic-claude-v1"
		| "google-gemini-v1"
	)?,
}

--[=[
    @interface RequestTimeoutResponseErrorData
    @within OpenRouterTypes
    Error data for RequestTimeoutResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type RequestTimeoutResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface RequestTimeoutResponse
    @within OpenRouterTypes
    Request Timeout - Operation exceeded time limit
    
    @field error RequestTimeoutResponseErrorData
    @field user_id string?
]=]
export type RequestTimeoutResponse = { error: RequestTimeoutResponseErrorData, user_id: string? }

--[=[
    @interface ResponseFormatJSONObject
    @within OpenRouterTypes
    JSON object response format
    
    @field type "json_object"
]=]
export type ResponseFormatJSONObject = { ["type"]: "json_object" }

--[=[
    @interface ResponseFormatJSONSchema
    @within OpenRouterTypes
    JSON Schema response format for structured outputs
    
    @field type "json_schema"
    @field json_schema JSONSchemaConfig
]=]
export type ResponseFormatJSONSchema = { ["type"]: "json_schema", json_schema: JSONSchemaConfig }

--[=[
    @interface ResponseFormatText
    @within OpenRouterTypes
    Default text response format
    
    @field type "text"
]=]
export type ResponseFormatText = { ["type"]: "text" }

--[=[
    @interface ResponseFormatTextGrammar
    @within OpenRouterTypes
    Custom grammar response format
    
    @field type "grammar"
    @field grammar string -- Custom grammar for text generation; (Ex: "root ::= \"yes\" | \"no\"")
]=]
export type ResponseFormatTextGrammar = { ["type"]: "grammar", grammar: string }

--[=[
    @interface ResponseFormatTextPython
    @within OpenRouterTypes
    Python code response format
    
    @field type "python"
]=]
export type ResponseFormatTextPython = { ["type"]: "python" }

--[=[
    @interface ResponseInputAudio
    @within OpenRouterTypes
    Audio input content item
    
    @field type "input_audio"
    @field input_audio { data: string, format: ("mp3" | "wav") }
]=]
export type ResponseInputAudio = { ["type"]: "input_audio", input_audio: { data: string, format: "mp3" | "wav" } }

--[=[
    @interface ResponseInputFile
    @within OpenRouterTypes
    File input content item
    
    @field type "input_file"
    @field file_id string?
    @field file_data string?
    @field filename string?
    @field file_url string?
]=]
export type ResponseInputFile = {
	["type"]: "input_file",
	file_id: string?,
	file_data: string?,
	filename: string?,
	file_url: string?,
}

--[=[
    @interface ResponseInputImage
    @within OpenRouterTypes
    Image input content item
    
    @field type "input_image"
    @field detail ("auto" | "high" | "low")
    @field image_url string?
]=]
export type ResponseInputImage = { ["type"]: "input_image", detail: "auto" | "high" | "low", image_url: string? }

--[=[
    @interface ResponseInputText
    @within OpenRouterTypes
    Text input content item
    
    @field type "input_text"
    @field text string
]=]
export type ResponseInputText = { ["type"]: "input_text", text: string }

--[=[
    @interface OpenAIResponsesPrompt
    @within OpenRouterTypes
    
    @field id string
    @field variables { [string]: (string | ResponseInputText | ResponseInputImage | ResponseInputFile) }?
]=]
export type OpenAIResponsesPrompt = {
	id: string,
	variables: { [string]: string | ResponseInputText | ResponseInputImage | ResponseInputFile }?,
}?

--[=[
    @interface ResponseInputVideo
    @within OpenRouterTypes
    Video input content item
    
    @field type "input_video"
    @field video_url string -- A base64 data URL or remote URL that resolves to a video file
]=]
export type ResponseInputVideo = { ["type"]: "input_video", video_url: string }

--[=[
    @interface OpenResponsesEasyInputMessage
    @within OpenRouterTypes
    
    @field type "message"?
    @field role ("user" | "system" | "assistant" | "developer")
    @field content ({(ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio | ResponseInputVideo)} | string)
]=]
export type OpenResponsesEasyInputMessage = {
	["type"]: "message"?,
	role: "user" | "system" | "assistant" | "developer",
	content: (
		{ ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio | ResponseInputVideo }
		| string
	),
}

--[=[
    @interface OpenResponsesInputMessageItem
    @within OpenRouterTypes
    
    @field id string?
    @field type "message"?
    @field role ("user" | "system" | "developer")
    @field content {(ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio | ResponseInputVideo)}
]=]
export type OpenResponsesInputMessageItem = {
	id: string?,
	["type"]: "message"?,
	role: "user" | "system" | "developer",
	content: { ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio | ResponseInputVideo },
}

--[=[
    @interface ResponsesErrorField
    @within OpenRouterTypes
    Error information returned from the API
    
    @field code ("server_error" | "rate_limit_exceeded" | "invalid_prompt" | "vector_store_timeout" | "invalid_image" | "invalid_image_format" | "invalid_base64_image" | "invalid_image_url" | "image_too_large" | "image_too_small" | "image_parse_error" | "image_content_policy_violation" | "invalid_image_mode" | "image_file_too_large" | "unsupported_image_media_type" | "empty_image_file" | "failed_to_download_image" | "image_file_not_found")
    @field message string
]=]
export type ResponsesErrorField = {
	code: (
		"server_error"
		| "rate_limit_exceeded"
		| "invalid_prompt"
		| "vector_store_timeout"
		| "invalid_image"
		| "invalid_image_format"
		| "invalid_base64_image"
		| "invalid_image_url"
		| "image_too_large"
		| "image_too_small"
		| "image_parse_error"
		| "image_content_policy_violation"
		| "invalid_image_mode"
		| "image_file_too_large"
		| "unsupported_image_media_type"
		| "empty_image_file"
		| "failed_to_download_image"
		| "image_file_not_found"
	),
	message: string,
}?

--[=[
    @interface ResponsesFormatText
    @within OpenRouterTypes
    Plain text response format
    
    @field type "text"
]=]
export type ResponsesFormatText = { ["type"]: "text" }

--[=[
    @interface ResponsesFormatTextJSONSchemaConfig
    @within OpenRouterTypes
    JSON schema constrained response format
    
    @field type "json_schema"
    @field name string
    @field description string?
    @field strict boolean?
    @field schema { [string]: any? }
]=]
export type ResponsesFormatTextJSONSchemaConfig = {
	["type"]: "json_schema",
	name: string,
	description: string?,
	strict: boolean?,
	schema: { [string]: any? },
}

--[=[
    @type ResponseFormatTextConfig (ResponsesFormatText | ResponseFormatJSONObject | ResponsesFormatTextJSONSchemaConfig)
    @within OpenRouterTypes
    Text response format configuration
]=]
export type ResponseFormatTextConfig = (
	ResponsesFormatText | ResponseFormatJSONObject | ResponsesFormatTextJSONSchemaConfig
)

--[=[
    @interface ResponseTextConfig
    @within OpenRouterTypes
    Text output configuration including format and verbosity
    
    @field format ResponseFormatTextConfig?
    @field verbosity ("high" | "low" | "medium")?
]=]
export type ResponseTextConfig = { format: ResponseFormatTextConfig?, verbosity: ("high" | "low" | "medium")? }

--[=[
    @type OpenResponsesResponseText ResponseTextConfig
    @within OpenRouterTypes
    Text output configuration including format and verbosity
]=]
export type OpenResponsesResponseText = ResponseTextConfig

--[=[
    @type ResponsesImageGenerationCall OutputItemImageGenerationCall
    @within OpenRouterTypes
]=]
export type ResponsesImageGenerationCall = OutputItemImageGenerationCall

--[=[
    @type ResponsesOutputItemFunctionCall OutputItemFunctionCall
    @within OpenRouterTypes
]=]
export type ResponsesOutputItemFunctionCall = OutputItemFunctionCall

--[=[
    @type ResponsesOutputItemReasoning (OutputItemReasoning & { content: {ReasoningTextContent}?, signature: string?, format: ("unknown" | "openai-responses-v1" | "azure-openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1" | "google-gemini-v1")? })
    @within OpenRouterTypes
    An output item containing reasoning
]=]
export type ResponsesOutputItemReasoning = OutputItemReasoning & {
	content: { ReasoningTextContent }?,
	signature: string?,
	format: (
		"unknown"
		| "openai-responses-v1"
		| "azure-openai-responses-v1"
		| "xai-responses-v1"
		| "anthropic-claude-v1"
		| "google-gemini-v1"
	)?,
}

--[=[
    @type ResponsesOutputModality ("text" | "image")
    @within OpenRouterTypes
]=]
export type ResponsesOutputModality = "text" | "image"

--[=[
    @type ResponsesSearchContextSize ("low" | "medium" | "high")
    @within OpenRouterTypes
    Size of the search context for web search tools
]=]
export type ResponsesSearchContextSize = "low" | "medium" | "high"

--[=[
    @interface ResponsesWebSearchUserLocation
    @within OpenRouterTypes
    User location information for web search
    
    @field type "approximate"?
    @field city string?
    @field country string?
    @field region string?
    @field timezone string?
]=]
export type ResponsesWebSearchUserLocation = {
	["type"]: "approximate"?,
	city: string?,
	country: string?,
	region: string?,
	timezone: string?,
}?

--[=[
    @interface OpenResponsesWebSearch20250826Tool
    @within OpenRouterTypes
    Web search tool configuration (2025-08-26 version)
    
    @field type "web_search_2025_08_26"
    @field filters { allowed_domains: {string}? }?
    @field search_context_size ResponsesSearchContextSize?
    @field user_location ResponsesWebSearchUserLocation?
]=]
export type OpenResponsesWebSearch20250826Tool = {
	["type"]: "web_search_2025_08_26",
	filters: { allowed_domains: { string }? }?,
	search_context_size: ResponsesSearchContextSize?,
	user_location: ResponsesWebSearchUserLocation?,
}

--[=[
    @interface OpenResponsesWebSearchTool
    @within OpenRouterTypes
    Web search tool configuration
    
    @field type "web_search"
    @field filters { allowed_domains: {string}? }?
    @field search_context_size ResponsesSearchContextSize?
    @field user_location ResponsesWebSearchUserLocation?
]=]
export type OpenResponsesWebSearchTool = {
	["type"]: "web_search",
	filters: { allowed_domains: { string }? }?,
	search_context_size: ResponsesSearchContextSize?,
	user_location: ResponsesWebSearchUserLocation?,
}

--[=[
    @interface ServiceUnavailableResponseErrorData
    @within OpenRouterTypes
    Error data for ServiceUnavailableResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type ServiceUnavailableResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface ServiceUnavailableResponse
    @within OpenRouterTypes
    Service Unavailable - Service temporarily unavailable
    
    @field error ServiceUnavailableResponseErrorData
    @field user_id string?
]=]
export type ServiceUnavailableResponse = { error: ServiceUnavailableResponseErrorData, user_id: string? }

--[=[
    @interface SystemMessage
    @within OpenRouterTypes
    System message for setting behavior
    
    @field role "system"
    @field content (string | {ChatMessageContentItemText}) -- System message content; (Ex: "You are a helpful assistant.")
    @field name string? -- Optional name for the system message; (Ex: "Assistant Config")
]=]
export type SystemMessage = { role: "system", content: string | { ChatMessageContentItemText }, name: string? }

--[=[
    @interface TooManyRequestsResponseErrorData
    @within OpenRouterTypes
    Error data for TooManyRequestsResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type TooManyRequestsResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface TooManyRequestsResponse
    @within OpenRouterTypes
    Too Many Requests - Rate limit exceeded
    
    @field error TooManyRequestsResponseErrorData
    @field user_id string?
]=]
export type TooManyRequestsResponse = { error: TooManyRequestsResponseErrorData, user_id: string? }

--[=[
    @type ToolCallStatus ("in_progress" | "completed" | "incomplete")?
    @within OpenRouterTypes
]=]
export type ToolCallStatus = ("in_progress" | "completed" | "incomplete")?

--[=[
    @interface OpenResponsesFunctionCallOutput
    @within OpenRouterTypes
    The output from a function call execution
    
    @field type "function_call_output"
    @field id string?
    @field call_id string
    @field output string
    @field status ToolCallStatus?
]=]
export type OpenResponsesFunctionCallOutput = {
	["type"]: "function_call_output",
	id: string?,
	call_id: string,
	output: string,
	status: ToolCallStatus?,
}

--[=[
    @interface OpenResponsesFunctionToolCall
    @within OpenRouterTypes
    A function call initiated by the model
    
    @field type "function_call"
    @field call_id string
    @field name string
    @field arguments string
    @field id string
    @field status ToolCallStatus?
]=]
export type OpenResponsesFunctionToolCall = {
	["type"]: "function_call",
	call_id: string,
	name: string,
	arguments: string,
	id: string,
	status: ToolCallStatus?,
}

--[=[
    @type ToolChoiceOption ("none" | "auto" | "required" | NamedToolChoice)
    @within OpenRouterTypes
    Tool choice configuration
]=]
export type ToolChoiceOption = "none" | "auto" | "required" | NamedToolChoice

--[=[
    @interface ToolDefinitionJson
    @within OpenRouterTypes
    Tool definition for function calling
    
    @field type "function"
    @field function { name: string, description: string?, parameters: { [string]: any? }?, strict: boolean? } -- Function definition for tool calling; (Ex: {"name":"get_weather","description":"Get the current weather for a location","parameters":{"type"...)
    @field cache_control ChatMessageContentItemCacheControl?
]=]
export type ToolDefinitionJson = {
	["type"]: "function",
	["function"]: { name: string, description: string?, parameters: { [string]: any? }?, strict: boolean? },
	cache_control: ChatMessageContentItemCacheControl?,
}

--[=[
    @interface TopProviderInfo
    @within OpenRouterTypes
    Information about the top provider for this model
    
    @field context_length number? -- Context length from the top provider; (Ex: 8192)
    @field max_completion_tokens number? -- Maximum completion tokens from the top provider; (Ex: 4096)
    @field is_moderated boolean -- Whether the top provider moderates content; (Ex: true)
]=]
export type TopProviderInfo = { context_length: number?, max_completion_tokens: number?, is_moderated: boolean }

--[=[
    @interface Model
    @within OpenRouterTypes
    Information about an AI model available on OpenRouter
    
    @field id string -- Unique identifier for the model; (Ex: "openai/gpt-4")
    @field canonical_slug string -- Canonical slug for the model; (Ex: "openai/gpt-4")
    @field hugging_face_id string? -- Hugging Face model identifier, if applicable; (Ex: "microsoft/DialoGPT-medium")
    @field name string -- Display name of the model; (Ex: "GPT-4")
    @field created number -- Unix timestamp of when the model was created; (Ex: 1692901234)
    @field description string? -- Description of the model; (Ex: "GPT-4 is a large multimodal model that can solve difficult problems with greater accuracy.")
    @field pricing PublicPricing
    @field context_length number? -- Maximum context length in tokens; (Ex: 8192)
    @field architecture ModelArchitecture
    @field top_provider TopProviderInfo
    @field per_request_limits PerRequestLimits
    @field supported_parameters {Parameter} -- List of supported parameters for this model
    @field default_parameters DefaultParameters
    @field expiration_date string? -- The date after which the model may be removed. ISO 8601 date string (YYYY-MM-DD) or null if no expiration.; (Ex: "2025-06-01")
]=]
export type Model = {
	id: string,
	canonical_slug: string,
	hugging_face_id: string?,
	name: string,
	created: number,
	description: string?,
	pricing: PublicPricing,
	context_length: number?,
	architecture: ModelArchitecture,
	top_provider: TopProviderInfo,
	per_request_limits: PerRequestLimits,
	supported_parameters: { Parameter },
	default_parameters: DefaultParameters,
	expiration_date: string?,
}

--[=[
    @type ModelsListResponseData {Model}
    @within OpenRouterTypes
    List of available models
]=]
export type ModelsListResponseData = { Model }

--[=[
    @interface ModelsListResponse
    @within OpenRouterTypes
    List of available models
    
    @field data ModelsListResponseData
]=]
export type ModelsListResponse = { data: ModelsListResponseData }

--[=[
    @interface URLCitation
    @within OpenRouterTypes
    
    @field type "url_citation"
    @field url string
    @field title string
    @field start_index number
    @field end_index number
]=]
export type URLCitation = { ["type"]: "url_citation", url: string, title: string, start_index: number, end_index: number }

--[=[
    @type OpenAIResponsesAnnotation (FileCitation | URLCitation | FilePath)
    @within OpenRouterTypes
]=]
export type OpenAIResponsesAnnotation = FileCitation | URLCitation | FilePath

--[=[
    @interface OpenResponsesOutputTextAnnotationAddedEvent
    @within OpenRouterTypes
    Event emitted when a text annotation is added to output
    
    @field type "response.output_text.annotation.added"
    @field output_index number
    @field item_id string
    @field content_index number
    @field sequence_number number
    @field annotation_index number
    @field annotation OpenAIResponsesAnnotation
]=]
export type OpenResponsesOutputTextAnnotationAddedEvent = {
	["type"]: "response.output_text.annotation.added",
	output_index: number,
	item_id: string,
	content_index: number,
	sequence_number: number,
	annotation_index: number,
	annotation: OpenAIResponsesAnnotation,
}

--[=[
    @interface ResponseOutputText
    @within OpenRouterTypes
    
    @field type "output_text"
    @field text string
    @field annotations {OpenAIResponsesAnnotation}?
    @field logprobs {{ token: string, bytes: {number}, logprob: number, top_logprobs: {{ token: string, bytes: {number}, logprob: number }} }}?
]=]
export type ResponseOutputText = {
	["type"]: "output_text",
	text: string,
	annotations: { OpenAIResponsesAnnotation }?,
	logprobs: {
		{
			token: string,
			bytes: { number },
			logprob: number,
			top_logprobs: { { token: string, bytes: { number }, logprob: number } },
		}
	}?,
}

--[=[
    @interface OpenResponsesContentPartAddedEvent
    @within OpenRouterTypes
    Event emitted when a new content part is added to an output item
    
    @field type "response.content_part.added"
    @field output_index number
    @field item_id string
    @field content_index number
    @field part (ResponseOutputText | OpenAIResponsesRefusalContent)
    @field sequence_number number
]=]
export type OpenResponsesContentPartAddedEvent = {
	["type"]: "response.content_part.added",
	output_index: number,
	item_id: string,
	content_index: number,
	part: ResponseOutputText | OpenAIResponsesRefusalContent,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesContentPartDoneEvent
    @within OpenRouterTypes
    Event emitted when a content part is complete
    
    @field type "response.content_part.done"
    @field output_index number
    @field item_id string
    @field content_index number
    @field part (ResponseOutputText | OpenAIResponsesRefusalContent)
    @field sequence_number number
]=]
export type OpenResponsesContentPartDoneEvent = {
	["type"]: "response.content_part.done",
	output_index: number,
	item_id: string,
	content_index: number,
	part: ResponseOutputText | OpenAIResponsesRefusalContent,
	sequence_number: number,
}

--[=[
    @interface OutputMessage
    @within OpenRouterTypes
    
    @field id string
    @field role "assistant"
    @field type "message"
    @field status ("completed" | "incomplete" | "in_progress")?
    @field content {(ResponseOutputText | OpenAIResponsesRefusalContent)}
]=]
export type OutputMessage = {
	id: string,
	role: "assistant",
	["type"]: "message",
	status: ("completed" | "incomplete" | "in_progress")?,
	content: { ResponseOutputText | OpenAIResponsesRefusalContent },
}

--[=[
    @type OpenAIResponsesInput (string | {({ ["type"]: "message"?, role: ("user" | "system" | "assistant" | "developer"), content: ({(ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio)} | string) } | { id: string, ["type"]: "message"?, role: ("user" | "system" | "developer"), content: {(ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio)} } | { ["type"]: "function_call_output", id: string?, call_id: string, output: string, status: ToolCallStatus? } | { ["type"]: "function_call", call_id: string, name: string, arguments: string, id: string?, status: ToolCallStatus? } | OutputItemImageGenerationCall | OutputMessage)})?
    @within OpenRouterTypes
]=]
export type OpenAIResponsesInput = (string | {
	{
		["type"]: "message"?,
		role: "user" | "system" | "assistant" | "developer",
		content: { ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio } | string,
	} | {
		id: string,
		["type"]: "message"?,
		role: "user" | "system" | "developer",
		content: { ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio },
	} | {
		["type"]: "function_call_output",
		id: string?,
		call_id: string,
		output: string,
		status: ToolCallStatus?,
	} | {
		["type"]: "function_call",
		call_id: string,
		name: string,
		arguments: string,
		id: string?,
		status: ToolCallStatus?,
	} | OutputItemImageGenerationCall | OutputMessage
})?

--[=[
    @type ResponsesOutputMessage OutputMessage
    @within OpenRouterTypes
    An output message item
]=]
export type ResponsesOutputMessage = OutputMessage

--[=[
    @interface UnauthorizedResponseErrorData
    @within OpenRouterTypes
    Error data for UnauthorizedResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type UnauthorizedResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface UnauthorizedResponse
    @within OpenRouterTypes
    Unauthorized - Authentication required or invalid credentials
    
    @field error UnauthorizedResponseErrorData
    @field user_id string?
]=]
export type UnauthorizedResponse = { error: UnauthorizedResponseErrorData, user_id: string? }

--[=[
    @interface UnprocessableEntityResponseErrorData
    @within OpenRouterTypes
    Error data for UnprocessableEntityResponse
    
    @field code number
    @field message string
    @field metadata { [string]: any? }?
]=]
export type UnprocessableEntityResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[=[
    @interface UnprocessableEntityResponse
    @within OpenRouterTypes
    Unprocessable Entity - Semantic validation failure
    
    @field error UnprocessableEntityResponseErrorData
    @field user_id string?
]=]
export type UnprocessableEntityResponse = { error: UnprocessableEntityResponseErrorData, user_id: string? }

--[=[
    @interface VideoInput
    @within OpenRouterTypes
    Video input object
    
    @field url string -- URL of the video (data: URLs supported)
]=]
export type VideoInput = { url: string }

--[=[
    @interface ChatMessageContentItemVideo
    @within OpenRouterTypes
    Video input content part
    
    @field type "video_url"
    @field video_url VideoInput
]=]
export type ChatMessageContentItemVideo = { ["type"]: "video_url", video_url: VideoInput }

--[=[
    @interface ChatMessageContentItemVideoLegacy
    @within OpenRouterTypes
    Video input content part (legacy format - deprecated)
    
    @field type "input_video"
    @field video_url VideoInput
]=]
export type ChatMessageContentItemVideoLegacy = { ["type"]: "input_video", video_url: VideoInput }

--[=[
    @type ChatMessageContentItem (ChatMessageContentItemText | ChatMessageContentItemImage | ChatMessageContentItemAudio | (ChatMessageContentItemVideoLegacy | ChatMessageContentItemVideo))
    @within OpenRouterTypes
    Content part for chat completion messages
]=]
export type ChatMessageContentItem = (
	ChatMessageContentItemText
	| ChatMessageContentItemImage
	| ChatMessageContentItemAudio
	| ChatMessageContentItemVideoLegacy
	| ChatMessageContentItemVideo
)

--[=[
    @interface AssistantMessage
    @within OpenRouterTypes
    Assistant message for requests and responses
    
    @field role "assistant"
    @field content (string | {ChatMessageContentItem})? -- Assistant message content
    @field name string? -- Optional name for the assistant
    @field tool_calls {ChatMessageToolCall}? -- Tool calls made by the assistant
    @field refusal string? -- Refusal message if content was refused
    @field reasoning string? -- Reasoning output
    @field reasoning_details AssistantMessageReasoningDetails?
    @field images AssistantMessageImages?
]=]
export type AssistantMessage = {
	role: "assistant",
	content: (string | { ChatMessageContentItem })?,
	name: string?,
	tool_calls: { ChatMessageToolCall }?,
	refusal: string?,
	reasoning: string?,
	reasoning_details: AssistantMessageReasoningDetails?,
	images: AssistantMessageImages?,
}

--[=[
    @interface ChatResponseChoice
    @within OpenRouterTypes
    Chat completion choice
    
    @field finish_reason ChatCompletionFinishReason?
    @field index number -- Choice index; (Ex: 0)
    @field message AssistantMessage
    @field logprobs ChatMessageTokenLogprobs?
]=]
export type ChatResponseChoice = {
	finish_reason: ChatCompletionFinishReason?,
	index: number,
	message: AssistantMessage,
	logprobs: ChatMessageTokenLogprobs?,
}

--[=[
    @interface ChatResponse
    @within OpenRouterTypes
    Chat completion response
    
    @field id string -- Unique completion identifier; (Ex: "chatcmpl-123")
    @field choices {ChatResponseChoice} -- List of completion choices
    @field created number -- Unix timestamp of creation; (Ex: 1677652288)
    @field model string -- Model used for completion; (Ex: "openai/gpt-4")
    @field object "chat.completion"
    @field system_fingerprint string? -- System fingerprint; (Ex: "fp_44709d6fcb")
    @field usage ChatGenerationTokenUsage?
]=]
export type ChatResponse = {
	id: string,
	choices: { ChatResponseChoice },
	created: number,
	model: string,
	object: "chat.completion",
	system_fingerprint: string?,
	usage: ChatGenerationTokenUsage?,
}

--[=[
    @interface ToolResponseMessage
    @within OpenRouterTypes
    Tool response message
    
    @field role "tool"
    @field content (string | {ChatMessageContentItem}) -- Tool response content; (Ex: "The weather in San Francisco is 72°F and sunny.")
    @field tool_call_id string -- ID of the assistant message tool call this message responds to; (Ex: "call_abc123")
]=]
export type ToolResponseMessage = { role: "tool", content: string | { ChatMessageContentItem }, tool_call_id: string }

--[=[
    @interface UserMessage
    @within OpenRouterTypes
    User message
    
    @field role "user"
    @field content (string | {ChatMessageContentItem}) -- User message content; (Ex: "What is the capital of France?")
    @field name string? -- Optional name for the user; (Ex: "User")
]=]
export type UserMessage = { role: "user", content: string | { ChatMessageContentItem }, name: string? }

--[=[
    @type Message (SystemMessage | UserMessage | DeveloperMessage | AssistantMessage | ToolResponseMessage)
    @within OpenRouterTypes
    Chat completion message with role-based discrimination
]=]
export type Message = SystemMessage | UserMessage | DeveloperMessage | AssistantMessage | ToolResponseMessage

--[=[
    @type WebSearchEngine ("native" | "exa")
    @within OpenRouterTypes
    The search engine to use for web search.
]=]
export type WebSearchEngine = "native" | "exa"

--[=[
    @interface AnthropicMessagesRequest
    @within OpenRouterTypes
    Request schema for Anthropic Messages API endpoint
    
    @field model string
    @field max_tokens number
    @field messages {OpenRouterAnthropicMessageParam}
    @field system (string | {{ ["type"]: "text", text: string, citations: {({ ["type"]: "char_location", cited_text: string, document_index: number, document_title: string?, start_char_index: number, end_char_index: number } | { ["type"]: "page_location", cited_text: string, document_index: number, document_title: string?, start_page_number: number, end_page_number: number } | { ["type"]: "content_block_location", cited_text: string, document_index: number, document_title: string?, start_block_index: number, end_block_index: number } | { ["type"]: "web_search_result_location", cited_text: string, encrypted_index: string, title: string?, url: string } | { ["type"]: "search_result_location", cited_text: string, search_result_index: number, source: string, title: string?, start_block_index: number, end_block_index: number })}?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? }})?
    @field metadata { user_id: string? }?
    @field stop_sequences {string}?
    @field stream boolean?
    @field temperature number?
    @field top_p number?
    @field top_k number?
    @field tools {({ name: string, description: string?, input_schema: { [string]: any? }, ["type"]: "custom"?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "bash_20250124", name: "bash", cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "text_editor_20250124", name: "str_replace_editor", cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? } | { ["type"]: "web_search_20250305", name: "web_search", allowed_domains: {string}?, blocked_domains: {string}?, max_uses: number?, user_location: { ["type"]: "approximate", city: string?, country: string?, region: string?, timezone: string? }?, cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }? })}?
    @field tool_choice ({ ["type"]: "auto", disable_parallel_tool_use: boolean? } | { ["type"]: "any", disable_parallel_tool_use: boolean? } | { ["type"]: "none" } | { ["type"]: "tool", name: string, disable_parallel_tool_use: boolean? })?
    @field thinking ({ ["type"]: "enabled", budget_tokens: number } | { ["type"]: "disabled" } | { ["type"]: "adaptive" })?
    @field service_tier ("auto" | "standard_only")?
    @field provider { allow_fallbacks: boolean?, require_parameters: boolean?, data_collection: DataCollection?, zdr: boolean?, enforce_distillable_text: boolean?, order: {(ProviderName | string)}?, only: {(ProviderName | string)}?, ignore: {(ProviderName | string)}?, quantizations: {Quantization}?, sort: (ProviderSort & (ProviderSort | ProviderSortConfig))?, max_price: { prompt: BigNumberUnion?, completion: BigNumberUnion?, image: BigNumberUnion?, audio: BigNumberUnion?, request: BigNumberUnion? }?, preferred_min_throughput: PreferredMinThroughput?, preferred_max_latency: PreferredMaxLatency? }? -- When multiple model providers are available, optionally indicate your routing preference.
    @field plugins {({ id: "auto-router", enabled: boolean?, allowed_models: {string}? } | { id: "moderation" } | { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? } | { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? } | { id: "response-healing", enabled: boolean? })}? -- Plugins you want to enable for this request, including their settings.
    @field route ("fallback" | "sort")? -- @deprecated; **DEPRECATED** Use providers.sort.partition instead. Backwards-compatible alias for providers.sort.partition. Accepts legacy values: "fallback" (maps to "model"), "sort" (maps to "none").
    @field user string? -- A unique identifier representing your end-user, which helps distinguish between different users of your app. This allows your app to identify specific users in case of abuse reports, preventing your entire app from being affected by the actions of individual users. Maximum of 128 characters.
    @field session_id string? -- A unique identifier for grouping related requests (e.g., a conversation or agent workflow) for observability. If provided in both the request body and the x-session-id header, the body value takes precedence. Maximum of 128 characters.
    @field trace { [string]: any? }? -- Metadata for observability and tracing. Known keys (trace_id, trace_name, span_name, generation_name, parent_span_id) have special handling. Additional keys are passed through as custom metadata to configured broadcast destinations.
    @field models {string}?
    @field output_config AnthropicOutputConfig?
]=]
export type AnthropicMessagesRequest = {
	model: string,
	max_tokens: number,
	messages: { OpenRouterAnthropicMessageParam },
	system: (string | {
		{
			["type"]: "text",
			text: string,
			citations: {
				{
					["type"]: "char_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_char_index: number,
					end_char_index: number,
				} | {
					["type"]: "page_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_page_number: number,
					end_page_number: number,
				} | {
					["type"]: "content_block_location",
					cited_text: string,
					document_index: number,
					document_title: string?,
					start_block_index: number,
					end_block_index: number,
				} | {
					["type"]: "web_search_result_location",
					cited_text: string,
					encrypted_index: string,
					title: string?,
					url: string,
				} | {
					["type"]: "search_result_location",
					cited_text: string,
					search_result_index: number,
					source: string,
					title: string?,
					start_block_index: number,
					end_block_index: number,
				}
			}?,
			cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
		}
	})?,
	metadata: { user_id: string? }?,
	stop_sequences: { string }?,
	stream: boolean?,
	temperature: number?,
	top_p: number?,
	top_k: number?,
	tools: {
		{
			name: string,
			description: string?,
			input_schema: { [string]: any? },
			["type"]: "custom"?,
			cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
		} | {
			["type"]: "bash_20250124",
			name: "bash",
			cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
		} | {
			["type"]: "text_editor_20250124",
			name: "str_replace_editor",
			cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
		} | {
			["type"]: "web_search_20250305",
			name: "web_search",
			allowed_domains: { string }?,
			blocked_domains: { string }?,
			max_uses: number?,
			user_location: {
				["type"]: "approximate",
				city: string?,
				country: string?,
				region: string?,
				timezone: string?,
			}?,
			cache_control: { ["type"]: "ephemeral", ttl: ("5m" | "1h")? }?,
		}
	}?,
	tool_choice: (
		{ ["type"]: "auto", disable_parallel_tool_use: boolean? }
		| { ["type"]: "any", disable_parallel_tool_use: boolean? }
		| { ["type"]: "none" }
		| { ["type"]: "tool", name: string, disable_parallel_tool_use: boolean? }
	)?,
	thinking: ({ ["type"]: "enabled", budget_tokens: number } | { ["type"]: "disabled" } | { ["type"]: "adaptive" })?,
	service_tier: ("auto" | "standard_only")?,
	provider: {
		allow_fallbacks: boolean?,
		require_parameters: boolean?,
		data_collection: DataCollection?,
		zdr: boolean?,
		enforce_distillable_text: boolean?,
		order: { ProviderName | string }?,
		only: { ProviderName | string }?,
		ignore: { ProviderName | string }?,
		quantizations: { Quantization }?,
		sort: (ProviderSort & (ProviderSort | ProviderSortConfig))?,
		max_price: {
			prompt: BigNumberUnion?,
			completion: BigNumberUnion?,
			image: BigNumberUnion?,
			audio: BigNumberUnion?,
			request: BigNumberUnion?,
		}?,
		preferred_min_throughput: PreferredMinThroughput?,
		preferred_max_latency: PreferredMaxLatency?,
	}?,
	plugins: {
		(
			{ id: "auto-router", enabled: boolean?, allowed_models: { string }? }
			| { id: "moderation" }
			| { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? }
			| { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? }
			| { id: "response-healing", enabled: boolean? }
		)
	}?,
	route: ("fallback" | "sort")?,
	user: string?,
	session_id: string?,
	trace: { [string]: any? }?,
	models: { string }?,
	output_config: AnthropicOutputConfig?,
}

--[=[
    @interface ChatGenerationParams
    @within OpenRouterTypes
    Chat completion request parameters
    
    @field provider { allow_fallbacks: boolean?, require_parameters: boolean?, data_collection: DataCollection?, zdr: boolean?, enforce_distillable_text: boolean?, order: {(ProviderName | string)}?, only: {(ProviderName | string)}?, ignore: {(ProviderName | string)}?, quantizations: {Quantization}?, sort: (ProviderSort & (ProviderSort | ProviderSortConfig))?, max_price: { prompt: BigNumberUnion?, completion: BigNumberUnion?, image: BigNumberUnion?, audio: BigNumberUnion?, request: BigNumberUnion? }?, preferred_min_throughput: PreferredMinThroughput?, preferred_max_latency: PreferredMaxLatency? }? -- When multiple model providers are available, optionally indicate your routing preference.
    @field plugins {({ id: "auto-router", enabled: boolean?, allowed_models: {string}? } | { id: "moderation" } | { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? } | { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? } | { id: "response-healing", enabled: boolean? })}? -- Plugins you want to enable for this request, including their settings.
    @field route ("fallback" | "sort")? -- @deprecated; **DEPRECATED** Use providers.sort.partition instead. Backwards-compatible alias for providers.sort.partition. Accepts legacy values: "fallback" (maps to "model"), "sort" (maps to "none").
    @field user string? -- Unique user identifier; (Ex: "user-123")
    @field session_id string? -- A unique identifier for grouping related requests (e.g., a conversation or agent workflow) for observability. If provided in both the request body and the x-session-id header, the body value takes precedence. Maximum of 128 characters.
    @field trace { [string]: any? }? -- Metadata for observability and tracing. Known keys (trace_id, trace_name, span_name, generation_name, parent_span_id) have special handling. Additional keys are passed through as custom metadata to configured broadcast destinations.
    @field messages {Message} -- List of messages for the conversation; (Ex: [{"role":"user","content":"Hello!"}])
    @field model ModelName?
    @field models ModelNames?
    @field frequency_penalty number? -- Frequency penalty (-2.0 to 2.0); Range: -2.0-2.0; (Ex: 0)
    @field logit_bias { [string]: number }? -- Token logit bias adjustments; (Ex: {"50256":-100})
    @field logprobs boolean? -- Return log probabilities; (Ex: false)
    @field top_logprobs number? -- Number of top log probabilities to return (0-20); Range: 0.0-20.0; (Ex: 5)
    @field max_completion_tokens number? -- Maximum tokens in completion; Min: 1.0; (Ex: 100)
    @field max_tokens number? -- Maximum tokens (deprecated, use max_completion_tokens); Min: 1.0; (Ex: 100)
    @field metadata { [string]: string }? -- Key-value pairs for additional object information (max 16 pairs, 64 char keys, 512 char values); (Ex: {"user_id":"user-123","session_id":"session-456"})
    @field presence_penalty number? -- Presence penalty (-2.0 to 2.0); Range: -2.0-2.0; (Ex: 0)
    @field reasoning { effort: ("xhigh" | "high" | "medium" | "low" | "minimal" | "none")?, summary: ReasoningSummaryVerbosity? }? -- Configuration options for reasoning models; (Ex: {"effort":"medium","summary":"concise"})
    @field response_format (ResponseFormatText | ResponseFormatJSONObject | ResponseFormatJSONSchema | ResponseFormatTextGrammar | ResponseFormatTextPython)? -- Response format configuration; (Ex: {"type":"json_object"})
    @field seed number? -- Random seed for deterministic outputs; (Ex: 42)
    @field stop (string | {string})? -- Stop sequences (up to 4); (Ex: ["\n"])
    @field stream boolean? -- Enable streaming response; Default: False; (Ex: false)
    @field stream_options ChatStreamOptions?
    @field temperature number? -- Sampling temperature (0-2); Range: 0.0-2.0; Default: 1; (Ex: 0.7)
    @field parallel_tool_calls boolean?
    @field tool_choice ToolChoiceOption?
    @field tools {ToolDefinitionJson}? -- Available tools for function calling; (Ex: [{"type":"function","function":{"name":"get_weather","description":"Get weather"}}])
    @field top_p number? -- Nucleus sampling parameter (0-1); Range: 0.0-1.0; Default: 1; (Ex: 1)
    @field debug DebugOptions?
    @field image_config { [string]: (string | number | {any?}) }? -- Provider-specific image configuration options. Keys and values vary by model/provider. See https://openrouter.ai/docs/guides/overview/multimodal/image-generation for more details.; (Ex: {"aspect_ratio":"16:9"})
    @field modalities {("text" | "image")}? -- Output modalities for the response. Supported values are "text" and "image".; (Ex: ["text","image"])
]=]
export type ChatGenerationParams = {
	provider: {
		allow_fallbacks: boolean?,
		require_parameters: boolean?,
		data_collection: DataCollection?,
		zdr: boolean?,
		enforce_distillable_text: boolean?,
		order: { ProviderName | string }?,
		only: { ProviderName | string }?,
		ignore: { ProviderName | string }?,
		quantizations: { Quantization }?,
		sort: (ProviderSort & (ProviderSort | ProviderSortConfig))?,
		max_price: {
			prompt: BigNumberUnion?,
			completion: BigNumberUnion?,
			image: BigNumberUnion?,
			audio: BigNumberUnion?,
			request: BigNumberUnion?,
		}?,
		preferred_min_throughput: PreferredMinThroughput?,
		preferred_max_latency: PreferredMaxLatency?,
	}?,
	plugins: {
		(
			{ id: "auto-router", enabled: boolean?, allowed_models: { string }? }
			| { id: "moderation" }
			| { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? }
			| { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? }
			| { id: "response-healing", enabled: boolean? }
		)
	}?,
	route: ("fallback" | "sort")?,
	user: string?,
	session_id: string?,
	trace: { [string]: any? }?,
	messages: { Message },
	model: ModelName?,
	models: ModelNames?,
	frequency_penalty: number?,
	logit_bias: { [string]: number }?,
	logprobs: boolean?,
	top_logprobs: number?,
	max_completion_tokens: number?,
	max_tokens: number?,
	metadata: { [string]: string }?,
	presence_penalty: number?,
	reasoning: {
		effort: ("xhigh" | "high" | "medium" | "low" | "minimal" | "none")?,
		summary: ReasoningSummaryVerbosity?,
	}?,
	response_format: (
		ResponseFormatText
		| ResponseFormatJSONObject
		| ResponseFormatJSONSchema
		| ResponseFormatTextGrammar
		| ResponseFormatTextPython
	)?,
	seed: number?,
	stop: (string | { string })?,
	stream: boolean?,
	stream_options: ChatStreamOptions?,
	temperature: number?,
	parallel_tool_calls: boolean?,
	tool_choice: ToolChoiceOption?,
	tools: { ToolDefinitionJson }?,
	top_p: number?,
	debug: DebugOptions?,
	image_config: { [string]: string | number | { any? } }?,
	modalities: { "text" | "image" }?,
}

--[=[
    @interface WebSearchPreviewToolUserLocation
    @within OpenRouterTypes
    
    @field type "approximate"
    @field city string?
    @field country string?
    @field region string?
    @field timezone string?
]=]
export type WebSearchPreviewToolUserLocation = {
	["type"]: "approximate",
	city: string?,
	country: string?,
	region: string?,
	timezone: string?,
}?

--[=[
    @interface OpenResponsesWebSearchPreview20250311Tool
    @within OpenRouterTypes
    Web search preview tool configuration (2025-03-11 version)
    
    @field type "web_search_preview_2025_03_11"
    @field search_context_size ResponsesSearchContextSize?
    @field user_location WebSearchPreviewToolUserLocation?
]=]
export type OpenResponsesWebSearchPreview20250311Tool = {
	["type"]: "web_search_preview_2025_03_11",
	search_context_size: ResponsesSearchContextSize?,
	user_location: WebSearchPreviewToolUserLocation?,
}

--[=[
    @interface OpenResponsesWebSearchPreviewTool
    @within OpenRouterTypes
    Web search preview tool configuration
    
    @field type "web_search_preview"
    @field search_context_size ResponsesSearchContextSize?
    @field user_location WebSearchPreviewToolUserLocation?
]=]
export type OpenResponsesWebSearchPreviewTool = {
	["type"]: "web_search_preview",
	search_context_size: ResponsesSearchContextSize?,
	user_location: WebSearchPreviewToolUserLocation?,
}

--[=[
    @type WebSearchStatus ("completed" | "searching" | "in_progress" | "failed")
    @within OpenRouterTypes
]=]
export type WebSearchStatus = "completed" | "searching" | "in_progress" | "failed"

--[=[
    @interface OutputItemFileSearchCall
    @within OpenRouterTypes
    
    @field type "file_search_call"
    @field id string
    @field queries {string}
    @field status WebSearchStatus
]=]
export type OutputItemFileSearchCall = {
	["type"]: "file_search_call",
	id: string,
	queries: { string },
	status: WebSearchStatus,
}

--[=[
    @interface OutputItemWebSearchCall
    @within OpenRouterTypes
    
    @field type "web_search_call"
    @field id string
    @field status WebSearchStatus
]=]
export type OutputItemWebSearchCall = { ["type"]: "web_search_call", id: string, status: WebSearchStatus }

--[=[
    @interface OpenAIResponsesNonStreamingResponse
    @within OpenRouterTypes
    
    @field id string
    @field object "response"
    @field created_at number
    @field model string
    @field status OpenAIResponsesResponseStatus
    @field completed_at number?
    @field output {(OutputMessage | OutputItemReasoning | OutputItemFunctionCall | OutputItemWebSearchCall | OutputItemFileSearchCall | OutputItemImageGenerationCall)}
    @field user string?
    @field output_text string?
    @field prompt_cache_key string?
    @field safety_identifier string?
    @field error ResponsesErrorField
    @field incomplete_details OpenAIResponsesIncompleteDetails
    @field usage OpenAIResponsesUsage?
    @field max_tool_calls number?
    @field top_logprobs number?
    @field max_output_tokens number?
    @field temperature number?
    @field top_p number?
    @field presence_penalty number?
    @field frequency_penalty number?
    @field instructions OpenAIResponsesInput
    @field metadata OpenResponsesRequestMetadata
    @field tools {(OpenResponsesFunctionTool | OpenResponsesWebSearchPreviewTool | OpenResponsesWebSearchPreview20250311Tool | OpenResponsesWebSearchTool | OpenResponsesWebSearch20250826Tool)}
    @field tool_choice OpenAIResponsesToolChoice
    @field parallel_tool_calls boolean
    @field prompt OpenAIResponsesPrompt?
    @field background boolean?
    @field previous_response_id string?
    @field reasoning OpenAIResponsesReasoningConfig?
    @field service_tier OpenAIResponsesServiceTier?
    @field store boolean?
    @field truncation OpenAIResponsesTruncation?
    @field text ResponseTextConfig?
]=]
export type OpenAIResponsesNonStreamingResponse = {
	id: string,
	object: "response",
	created_at: number,
	model: string,
	status: OpenAIResponsesResponseStatus,
	completed_at: number?,
	output: {
		(
			OutputMessage
			| OutputItemReasoning
			| OutputItemFunctionCall
			| OutputItemWebSearchCall
			| OutputItemFileSearchCall
			| OutputItemImageGenerationCall
		)
	},
	user: string?,
	output_text: string?,
	prompt_cache_key: string?,
	safety_identifier: string?,
	error: ResponsesErrorField,
	incomplete_details: OpenAIResponsesIncompleteDetails,
	usage: OpenAIResponsesUsage?,
	max_tool_calls: number?,
	top_logprobs: number?,
	max_output_tokens: number?,
	temperature: number?,
	top_p: number?,
	presence_penalty: number?,
	frequency_penalty: number?,
	instructions: OpenAIResponsesInput,
	metadata: OpenResponsesRequestMetadata,
	tools: {
		(
			OpenResponsesFunctionTool
			| OpenResponsesWebSearchPreviewTool
			| OpenResponsesWebSearchPreview20250311Tool
			| OpenResponsesWebSearchTool
			| OpenResponsesWebSearch20250826Tool
		)
	},
	tool_choice: OpenAIResponsesToolChoice,
	parallel_tool_calls: boolean,
	prompt: OpenAIResponsesPrompt?,
	background: boolean?,
	previous_response_id: string?,
	reasoning: OpenAIResponsesReasoningConfig?,
	service_tier: OpenAIResponsesServiceTier?,
	store: boolean?,
	truncation: OpenAIResponsesTruncation?,
	text: ResponseTextConfig?,
}

--[=[
    @interface OpenResponsesCompletedEvent
    @within OpenRouterTypes
    Event emitted when a response has completed successfully
    
    @field type "response.completed"
    @field response OpenAIResponsesNonStreamingResponse
    @field sequence_number number
]=]
export type OpenResponsesCompletedEvent = {
	["type"]: "response.completed",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesCreatedEvent
    @within OpenRouterTypes
    Event emitted when a response is created
    
    @field type "response.created"
    @field response OpenAIResponsesNonStreamingResponse
    @field sequence_number number
]=]
export type OpenResponsesCreatedEvent = {
	["type"]: "response.created",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesFailedEvent
    @within OpenRouterTypes
    Event emitted when a response has failed
    
    @field type "response.failed"
    @field response OpenAIResponsesNonStreamingResponse
    @field sequence_number number
]=]
export type OpenResponsesFailedEvent = {
	["type"]: "response.failed",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesInProgressEvent
    @within OpenRouterTypes
    Event emitted when a response is in progress
    
    @field type "response.in_progress"
    @field response OpenAIResponsesNonStreamingResponse
    @field sequence_number number
]=]
export type OpenResponsesInProgressEvent = {
	["type"]: "response.in_progress",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesIncompleteEvent
    @within OpenRouterTypes
    Event emitted when a response is incomplete
    
    @field type "response.incomplete"
    @field response OpenAIResponsesNonStreamingResponse
    @field sequence_number number
]=]
export type OpenResponsesIncompleteEvent = {
	["type"]: "response.incomplete",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[=[
    @interface OpenResponsesOutputItemAddedEvent
    @within OpenRouterTypes
    Event emitted when a new output item is added to the response
    
    @field type "response.output_item.added"
    @field output_index number
    @field item (OutputMessage | OutputItemReasoning | OutputItemFunctionCall | OutputItemWebSearchCall | OutputItemFileSearchCall | OutputItemImageGenerationCall)
    @field sequence_number number
]=]
export type OpenResponsesOutputItemAddedEvent = {
	["type"]: "response.output_item.added",
	output_index: number,
	item: (
		OutputMessage
		| OutputItemReasoning
		| OutputItemFunctionCall
		| OutputItemWebSearchCall
		| OutputItemFileSearchCall
		| OutputItemImageGenerationCall
	),
	sequence_number: number,
}

--[=[
    @interface OpenResponsesOutputItemDoneEvent
    @within OpenRouterTypes
    Event emitted when an output item is complete
    
    @field type "response.output_item.done"
    @field output_index number
    @field item (OutputMessage | OutputItemReasoning | OutputItemFunctionCall | OutputItemWebSearchCall | OutputItemFileSearchCall | OutputItemImageGenerationCall)
    @field sequence_number number
]=]
export type OpenResponsesOutputItemDoneEvent = {
	["type"]: "response.output_item.done",
	output_index: number,
	item: (
		OutputMessage
		| OutputItemReasoning
		| OutputItemFunctionCall
		| OutputItemWebSearchCall
		| OutputItemFileSearchCall
		| OutputItemImageGenerationCall
	),
	sequence_number: number,
}

--[=[
    @type ResponsesOutputItemFileSearchCall OutputItemFileSearchCall
    @within OpenRouterTypes
]=]
export type ResponsesOutputItemFileSearchCall = OutputItemFileSearchCall

--[=[
    @type ResponsesWebSearchCallOutput OutputItemWebSearchCall
    @within OpenRouterTypes
]=]
export type ResponsesWebSearchCallOutput = OutputItemWebSearchCall

--[=[
    @type OpenResponsesInput (string | {(OpenResponsesReasoning | OpenResponsesEasyInputMessage | OpenResponsesInputMessageItem | OpenResponsesFunctionToolCall | OpenResponsesFunctionCallOutput | ResponsesOutputMessage | ResponsesOutputItemReasoning | ResponsesOutputItemFunctionCall | ResponsesWebSearchCallOutput | ResponsesOutputItemFileSearchCall | ResponsesImageGenerationCall)})
    @within OpenRouterTypes
    Input for a response request - can be a string or array of items
]=]
export type OpenResponsesInput =
	string
	| {
		(
			OpenResponsesReasoning
			| OpenResponsesEasyInputMessage
			| OpenResponsesInputMessageItem
			| OpenResponsesFunctionToolCall
			| OpenResponsesFunctionCallOutput
			| ResponsesOutputMessage
			| ResponsesOutputItemReasoning
			| ResponsesOutputItemFunctionCall
			| ResponsesWebSearchCallOutput
			| ResponsesOutputItemFileSearchCall
			| ResponsesImageGenerationCall
		)
	}

--[=[
    @interface OpenResponsesRequest
    @within OpenRouterTypes
    Request schema for Responses endpoint
    
    @field input OpenResponsesInput?
    @field instructions string?
    @field metadata OpenResponsesRequestMetadata?
    @field tools {(OpenResponsesFunctionTool | OpenResponsesWebSearchPreviewTool | OpenResponsesWebSearchPreview20250311Tool | OpenResponsesWebSearchTool | OpenResponsesWebSearch20250826Tool)}?
    @field tool_choice OpenAIResponsesToolChoice?
    @field parallel_tool_calls boolean?
    @field model string?
    @field models {string}?
    @field text OpenResponsesResponseText?
    @field reasoning OpenResponsesReasoningConfig?
    @field max_output_tokens number?
    @field temperature number? -- Range: 0.0-2.0
    @field top_p number? -- Min: 0.0
    @field top_logprobs number? -- Range: 0.0-20.0
    @field max_tool_calls number?
    @field presence_penalty number? -- Range: -2.0-2.0
    @field frequency_penalty number? -- Range: -2.0-2.0
    @field top_k number?
    @field image_config { [string]: (string | number) }? -- Provider-specific image configuration options. Keys and values vary by model/provider. See https://openrouter.ai/docs/features/multimodal/image-generation for more details.; (Ex: {"aspect_ratio":"16:9"})
    @field modalities {ResponsesOutputModality}? -- Output modalities for the response. Supported values are "text" and "image".; (Ex: ["text","image"])
    @field prompt_cache_key string?
    @field previous_response_id string?
    @field prompt OpenAIResponsesPrompt?
    @field include {OpenAIResponsesIncludable}?
    @field background boolean?
    @field safety_identifier string?
    @field store boolean? -- Default: False
    @field service_tier "auto"? -- Default: 'auto'
    @field truncation OpenAIResponsesTruncation?
    @field stream boolean? -- Default: False
    @field provider { allow_fallbacks: boolean?, require_parameters: boolean?, data_collection: DataCollection?, zdr: boolean?, enforce_distillable_text: boolean?, order: {(ProviderName | string)}?, only: {(ProviderName | string)}?, ignore: {(ProviderName | string)}?, quantizations: {Quantization}?, sort: (ProviderSort | ProviderSortConfig)?, max_price: { prompt: BigNumberUnion?, completion: BigNumberUnion?, image: BigNumberUnion?, audio: BigNumberUnion?, request: BigNumberUnion? }?, preferred_min_throughput: PreferredMinThroughput?, preferred_max_latency: PreferredMaxLatency? }? -- When multiple model providers are available, optionally indicate your routing preference.
    @field plugins {({ id: "auto-router", enabled: boolean?, allowed_models: {string}? } | { id: "moderation" } | { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? } | { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? } | { id: "response-healing", enabled: boolean? })}? -- Plugins you want to enable for this request, including their settings.
    @field route ("fallback" | "sort")? -- @deprecated; **DEPRECATED** Use providers.sort.partition instead. Backwards-compatible alias for providers.sort.partition. Accepts legacy values: "fallback" (maps to "model"), "sort" (maps to "none").
    @field user string? -- A unique identifier representing your end-user, which helps distinguish between different users of your app. This allows your app to identify specific users in case of abuse reports, preventing your entire app from being affected by the actions of individual users. Maximum of 128 characters.
    @field session_id string? -- A unique identifier for grouping related requests (e.g., a conversation or agent workflow) for observability. If provided in both the request body and the x-session-id header, the body value takes precedence. Maximum of 128 characters.
    @field trace { [string]: any? }? -- Metadata for observability and tracing. Known keys (trace_id, trace_name, span_name, generation_name, parent_span_id) have special handling. Additional keys are passed through as custom metadata to configured broadcast destinations.
]=]
export type OpenResponsesRequest = {
	input: OpenResponsesInput?,
	instructions: string?,
	metadata: OpenResponsesRequestMetadata?,
	tools: {
		(
			OpenResponsesFunctionTool
			| OpenResponsesWebSearchPreviewTool
			| OpenResponsesWebSearchPreview20250311Tool
			| OpenResponsesWebSearchTool
			| OpenResponsesWebSearch20250826Tool
		)
	}?,
	tool_choice: OpenAIResponsesToolChoice?,
	parallel_tool_calls: boolean?,
	model: string?,
	models: { string }?,
	text: OpenResponsesResponseText?,
	reasoning: OpenResponsesReasoningConfig?,
	max_output_tokens: number?,
	temperature: number?,
	top_p: number?,
	top_logprobs: number?,
	max_tool_calls: number?,
	presence_penalty: number?,
	frequency_penalty: number?,
	top_k: number?,
	image_config: { [string]: string | number }?,
	modalities: { ResponsesOutputModality }?,
	prompt_cache_key: string?,
	previous_response_id: string?,
	prompt: OpenAIResponsesPrompt?,
	include: { OpenAIResponsesIncludable }?,
	background: boolean?,
	safety_identifier: string?,
	store: boolean?,
	service_tier: "auto"?,
	truncation: OpenAIResponsesTruncation?,
	stream: boolean?,
	provider: {
		allow_fallbacks: boolean?,
		require_parameters: boolean?,
		data_collection: DataCollection?,
		zdr: boolean?,
		enforce_distillable_text: boolean?,
		order: { ProviderName | string }?,
		only: { ProviderName | string }?,
		ignore: { ProviderName | string }?,
		quantizations: { Quantization }?,
		sort: (ProviderSort | ProviderSortConfig)?,
		max_price: {
			prompt: BigNumberUnion?,
			completion: BigNumberUnion?,
			image: BigNumberUnion?,
			audio: BigNumberUnion?,
			request: BigNumberUnion?,
		}?,
		preferred_min_throughput: PreferredMinThroughput?,
		preferred_max_latency: PreferredMaxLatency?,
	}?,
	plugins: {
		(
			{ id: "auto-router", enabled: boolean?, allowed_models: { string }? }
			| { id: "moderation" }
			| { id: "web", enabled: boolean?, max_results: number?, search_prompt: string?, engine: WebSearchEngine? }
			| { id: "file-parser", enabled: boolean?, pdf: PDFParserOptions? }
			| { id: "response-healing", enabled: boolean? }
		)
	}?,
	route: ("fallback" | "sort")?,
	user: string?,
	session_id: string?,
	trace: { [string]: any? }?,
}

--[=[
    @type ResponsesOutputItem (ResponsesOutputMessage | ResponsesOutputItemReasoning | ResponsesOutputItemFunctionCall | ResponsesWebSearchCallOutput | ResponsesOutputItemFileSearchCall | ResponsesImageGenerationCall)
    @within OpenRouterTypes
    An output item from the response
]=]
export type ResponsesOutputItem = (
	ResponsesOutputMessage
	| ResponsesOutputItemReasoning
	| ResponsesOutputItemFunctionCall
	| ResponsesWebSearchCallOutput
	| ResponsesOutputItemFileSearchCall
	| ResponsesImageGenerationCall
)

--[=[
    @type OpenResponsesNonStreamingResponse (OpenAIResponsesNonStreamingResponse & { output: {ResponsesOutputItem}?, usage: OpenResponsesUsage? })
    @within OpenRouterTypes
    Complete non-streaming response from the Responses API
]=]
export type OpenResponsesNonStreamingResponse = (
	OpenAIResponsesNonStreamingResponse & { output: { ResponsesOutputItem }?, usage: OpenResponsesUsage? }
)

--[=[
    @type OpenResponsesStreamEvent ((OpenResponsesCreatedEvent & { response: OpenResponsesNonStreamingResponse? }) | (OpenResponsesInProgressEvent & { response: OpenResponsesNonStreamingResponse? }) | (OpenResponsesCompletedEvent & { response: OpenResponsesNonStreamingResponse? }) | (OpenResponsesIncompleteEvent & { response: OpenResponsesNonStreamingResponse? }) | (OpenResponsesFailedEvent & { response: OpenResponsesNonStreamingResponse? }) | OpenResponsesErrorEvent | (OpenResponsesOutputItemAddedEvent & { item: ResponsesOutputItem? }) | (OpenResponsesOutputItemDoneEvent & { item: ResponsesOutputItem? }) | (OpenResponsesContentPartAddedEvent & { part: (ResponseOutputText | ReasoningTextContent | OpenAIResponsesRefusalContent)? }) | (OpenResponsesContentPartDoneEvent & { part: (ResponseOutputText | ReasoningTextContent | OpenAIResponsesRefusalContent)? }) | OpenResponsesTextDeltaEvent | OpenResponsesTextDoneEvent | OpenResponsesRefusalDeltaEvent | OpenResponsesRefusalDoneEvent | OpenResponsesOutputTextAnnotationAddedEvent | OpenResponsesFunctionCallArgumentsDeltaEvent | OpenResponsesFunctionCallArgumentsDoneEvent | OpenResponsesReasoningDeltaEvent | OpenResponsesReasoningDoneEvent | OpenResponsesReasoningSummaryPartAddedEvent | OpenResponsesReasoningSummaryPartDoneEvent | OpenResponsesReasoningSummaryTextDeltaEvent | OpenResponsesReasoningSummaryTextDoneEvent | OpenResponsesImageGenCallInProgress | OpenResponsesImageGenCallGenerating | OpenResponsesImageGenCallPartialImage | OpenResponsesImageGenCallCompleted)
    @within OpenRouterTypes
    Union of all possible event types emitted during response streaming
]=]
export type OpenResponsesStreamEvent = (
	(OpenResponsesCreatedEvent & { response: OpenResponsesNonStreamingResponse? })
	| (OpenResponsesInProgressEvent & { response: OpenResponsesNonStreamingResponse? })
	| (OpenResponsesCompletedEvent & { response: OpenResponsesNonStreamingResponse? })
	| (OpenResponsesIncompleteEvent & { response: OpenResponsesNonStreamingResponse? })
	| (OpenResponsesFailedEvent & { response: OpenResponsesNonStreamingResponse? })
	| OpenResponsesErrorEvent
	| (OpenResponsesOutputItemAddedEvent & { item: ResponsesOutputItem? })
	| (OpenResponsesOutputItemDoneEvent & { item: ResponsesOutputItem? })
	| (
		OpenResponsesContentPartAddedEvent
		& { part: (ResponseOutputText | ReasoningTextContent | OpenAIResponsesRefusalContent)? }
	)
	| (
		OpenResponsesContentPartDoneEvent
		& { part: (ResponseOutputText | ReasoningTextContent | OpenAIResponsesRefusalContent)? }
	)
	| OpenResponsesTextDeltaEvent
	| OpenResponsesTextDoneEvent
	| OpenResponsesRefusalDeltaEvent
	| OpenResponsesRefusalDoneEvent
	| OpenResponsesOutputTextAnnotationAddedEvent
	| OpenResponsesFunctionCallArgumentsDeltaEvent
	| OpenResponsesFunctionCallArgumentsDoneEvent
	| OpenResponsesReasoningDeltaEvent
	| OpenResponsesReasoningDoneEvent
	| OpenResponsesReasoningSummaryPartAddedEvent
	| OpenResponsesReasoningSummaryPartDoneEvent
	| OpenResponsesReasoningSummaryTextDeltaEvent
	| OpenResponsesReasoningSummaryTextDoneEvent
	| OpenResponsesImageGenCallInProgress
	| OpenResponsesImageGenCallGenerating
	| OpenResponsesImageGenCallPartialImage
	| OpenResponsesImageGenCallCompleted
)

--[=[
    @type CreateResponses200Response OpenResponsesNonStreamingResponse
    @within OpenRouterTypes
    200 Response type for createResponses
]=]
export type CreateResponses200Response = OpenResponsesNonStreamingResponse

--[=[
    @type CreateResponses400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createResponses
]=]
export type CreateResponses400Response = BadRequestResponse

--[=[
    @type CreateResponses401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createResponses
]=]
export type CreateResponses401Response = UnauthorizedResponse

--[=[
    @type CreateResponses402Response PaymentRequiredResponse
    @within OpenRouterTypes
    402 Response type for createResponses
]=]
export type CreateResponses402Response = PaymentRequiredResponse

--[=[
    @type CreateResponses404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for createResponses
]=]
export type CreateResponses404Response = NotFoundResponse

--[=[
    @type CreateResponses408Response RequestTimeoutResponse
    @within OpenRouterTypes
    408 Response type for createResponses
]=]
export type CreateResponses408Response = RequestTimeoutResponse

--[=[
    @type CreateResponses413Response PayloadTooLargeResponse
    @within OpenRouterTypes
    413 Response type for createResponses
]=]
export type CreateResponses413Response = PayloadTooLargeResponse

--[=[
    @type CreateResponses422Response UnprocessableEntityResponse
    @within OpenRouterTypes
    422 Response type for createResponses
]=]
export type CreateResponses422Response = UnprocessableEntityResponse

--[=[
    @type CreateResponses429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for createResponses
]=]
export type CreateResponses429Response = TooManyRequestsResponse

--[=[
    @type CreateResponses500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createResponses
]=]
export type CreateResponses500Response = InternalServerResponse

--[=[
    @type CreateResponses502Response BadGatewayResponse
    @within OpenRouterTypes
    502 Response type for createResponses
]=]
export type CreateResponses502Response = BadGatewayResponse

--[=[
    @type CreateResponses503Response ServiceUnavailableResponse
    @within OpenRouterTypes
    503 Response type for createResponses
]=]
export type CreateResponses503Response = ServiceUnavailableResponse

--[=[
    @type CreateResponses524Response EdgeNetworkTimeoutResponse
    @within OpenRouterTypes
    524 Response type for createResponses
]=]
export type CreateResponses524Response = EdgeNetworkTimeoutResponse

--[=[
    @type CreateResponses529Response ProviderOverloadedResponse
    @within OpenRouterTypes
    529 Response type for createResponses
]=]
export type CreateResponses529Response = ProviderOverloadedResponse

--[=[
    @type CreateMessages200Response AnthropicMessagesResponse
    @within OpenRouterTypes
    200 Response type for createMessages
]=]
export type CreateMessages200Response = AnthropicMessagesResponse

--[=[
    @type CreateMessages400Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    400 Response type for createMessages
]=]
export type CreateMessages400Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages401Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    401 Response type for createMessages
]=]
export type CreateMessages401Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages403Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    403 Response type for createMessages
]=]
export type CreateMessages403Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages404Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    404 Response type for createMessages
]=]
export type CreateMessages404Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages429Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    429 Response type for createMessages
]=]
export type CreateMessages429Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages500Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    500 Response type for createMessages
]=]
export type CreateMessages500Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages503Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    503 Response type for createMessages
]=]
export type CreateMessages503Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type CreateMessages529Response { ["type"]: "error", error: { ["type"]: string, message: string } }
    @within OpenRouterTypes
    529 Response type for createMessages
]=]
export type CreateMessages529Response = { ["type"]: "error", error: { ["type"]: string, message: string } }

--[=[
    @type GetUserActivity200Response { data: {ActivityItem} }
    @within OpenRouterTypes
    200 Response type for getUserActivity
]=]
export type GetUserActivity200Response = { data: { ActivityItem } }

--[=[
    @type GetUserActivity400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for getUserActivity
]=]
export type GetUserActivity400Response = BadRequestResponse

--[=[
    @type GetUserActivity401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getUserActivity
]=]
export type GetUserActivity401Response = UnauthorizedResponse

--[=[
    @type GetUserActivity403Response ForbiddenResponse
    @within OpenRouterTypes
    403 Response type for getUserActivity
]=]
export type GetUserActivity403Response = ForbiddenResponse

--[=[
    @type GetUserActivity500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getUserActivity
]=]
export type GetUserActivity500Response = InternalServerResponse

--[=[
    @type SendChatCompletionRequest200Response ChatResponse
    @within OpenRouterTypes
    200 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest200Response = ChatResponse

--[=[
    @type SendChatCompletionRequest400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest400Response = BadRequestResponse

--[=[
    @type SendChatCompletionRequest401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest401Response = UnauthorizedResponse

--[=[
    @type SendChatCompletionRequest402Response PaymentRequiredResponse
    @within OpenRouterTypes
    402 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest402Response = PaymentRequiredResponse

--[=[
    @type SendChatCompletionRequest404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest404Response = NotFoundResponse

--[=[
    @type SendChatCompletionRequest408Response RequestTimeoutResponse
    @within OpenRouterTypes
    408 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest408Response = RequestTimeoutResponse

--[=[
    @type SendChatCompletionRequest413Response PayloadTooLargeResponse
    @within OpenRouterTypes
    413 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest413Response = PayloadTooLargeResponse

--[=[
    @type SendChatCompletionRequest422Response UnprocessableEntityResponse
    @within OpenRouterTypes
    422 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest422Response = UnprocessableEntityResponse

--[=[
    @type SendChatCompletionRequest429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest429Response = TooManyRequestsResponse

--[=[
    @type SendChatCompletionRequest500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest500Response = InternalServerResponse

--[=[
    @type SendChatCompletionRequest502Response BadGatewayResponse
    @within OpenRouterTypes
    502 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest502Response = BadGatewayResponse

--[=[
    @type SendChatCompletionRequest503Response ServiceUnavailableResponse
    @within OpenRouterTypes
    503 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest503Response = ServiceUnavailableResponse

--[=[
    @type SendChatCompletionRequest524Response EdgeNetworkTimeoutResponse
    @within OpenRouterTypes
    524 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest524Response = EdgeNetworkTimeoutResponse

--[=[
    @type SendChatCompletionRequest529Response ProviderOverloadedResponse
    @within OpenRouterTypes
    529 Response type for sendChatCompletionRequest
]=]
export type SendChatCompletionRequest529Response = ProviderOverloadedResponse

--[=[
    @type GetCredits200Response { data: { total_credits: number, total_usage: number } }
    @within OpenRouterTypes
    200 Response type for getCredits
]=]
export type GetCredits200Response = { data: { total_credits: number, total_usage: number } }

--[=[
    @type GetCredits401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getCredits
]=]
export type GetCredits401Response = UnauthorizedResponse

--[=[
    @type GetCredits403Response ForbiddenResponse
    @within OpenRouterTypes
    403 Response type for getCredits
]=]
export type GetCredits403Response = ForbiddenResponse

--[=[
    @type GetCredits500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getCredits
]=]
export type GetCredits500Response = InternalServerResponse

--[=[
    @type CreateCoinbaseCharge200Response { data: { id: string, created_at: string, expires_at: string, web3_data: { transfer_intent: { call_data: { deadline: string, fee_amount: string, id: string, operator: string, prefix: string, recipient: string, recipient_amount: string, recipient_currency: string, refund_destination: string, signature: string }, metadata: { chain_id: number, contract_address: string, sender: string } } } } }
    @within OpenRouterTypes
    200 Response type for createCoinbaseCharge
]=]
export type CreateCoinbaseCharge200Response = {
	data: {
		id: string,
		created_at: string,
		expires_at: string,
		web3_data: {
			transfer_intent: {
				call_data: {
					deadline: string,
					fee_amount: string,
					id: string,
					operator: string,
					prefix: string,
					recipient: string,
					recipient_amount: string,
					recipient_currency: string,
					refund_destination: string,
					signature: string,
				},
				metadata: { chain_id: number, contract_address: string, sender: string },
			},
		},
	},
}

--[=[
    @type CreateCoinbaseCharge400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createCoinbaseCharge
]=]
export type CreateCoinbaseCharge400Response = BadRequestResponse

--[=[
    @type CreateCoinbaseCharge401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createCoinbaseCharge
]=]
export type CreateCoinbaseCharge401Response = UnauthorizedResponse

--[=[
    @type CreateCoinbaseCharge429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for createCoinbaseCharge
]=]
export type CreateCoinbaseCharge429Response = TooManyRequestsResponse

--[=[
    @type CreateCoinbaseCharge500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createCoinbaseCharge
]=]
export type CreateCoinbaseCharge500Response = InternalServerResponse

--[=[
    @type CreateEmbeddings200Response { id: string?, object: "list", data: {{ object: "embedding", embedding: ({number} | string), index: number? }}, model: string, usage: { prompt_tokens: number, total_tokens: number, cost: number? }? }
    @within OpenRouterTypes
    200 Response type for createEmbeddings
]=]
export type CreateEmbeddings200Response = {
	id: string?,
	object: "list",
	data: { { object: "embedding", embedding: { number } | string, index: number? } },
	model: string,
	usage: { prompt_tokens: number, total_tokens: number, cost: number? }?,
}

--[=[
    @type CreateEmbeddings400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createEmbeddings
]=]
export type CreateEmbeddings400Response = BadRequestResponse

--[=[
    @type CreateEmbeddings401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createEmbeddings
]=]
export type CreateEmbeddings401Response = UnauthorizedResponse

--[=[
    @type CreateEmbeddings402Response PaymentRequiredResponse
    @within OpenRouterTypes
    402 Response type for createEmbeddings
]=]
export type CreateEmbeddings402Response = PaymentRequiredResponse

--[=[
    @type CreateEmbeddings404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for createEmbeddings
]=]
export type CreateEmbeddings404Response = NotFoundResponse

--[=[
    @type CreateEmbeddings429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for createEmbeddings
]=]
export type CreateEmbeddings429Response = TooManyRequestsResponse

--[=[
    @type CreateEmbeddings500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createEmbeddings
]=]
export type CreateEmbeddings500Response = InternalServerResponse

--[=[
    @type CreateEmbeddings502Response BadGatewayResponse
    @within OpenRouterTypes
    502 Response type for createEmbeddings
]=]
export type CreateEmbeddings502Response = BadGatewayResponse

--[=[
    @type CreateEmbeddings503Response ServiceUnavailableResponse
    @within OpenRouterTypes
    503 Response type for createEmbeddings
]=]
export type CreateEmbeddings503Response = ServiceUnavailableResponse

--[=[
    @type CreateEmbeddings524Response EdgeNetworkTimeoutResponse
    @within OpenRouterTypes
    524 Response type for createEmbeddings
]=]
export type CreateEmbeddings524Response = EdgeNetworkTimeoutResponse

--[=[
    @type CreateEmbeddings529Response ProviderOverloadedResponse
    @within OpenRouterTypes
    529 Response type for createEmbeddings
]=]
export type CreateEmbeddings529Response = ProviderOverloadedResponse

--[=[
    @type ListEmbeddingsModels200Response ModelsListResponse
    @within OpenRouterTypes
    200 Response type for listEmbeddingsModels
]=]
export type ListEmbeddingsModels200Response = ModelsListResponse

--[=[
    @type ListEmbeddingsModels400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for listEmbeddingsModels
]=]
export type ListEmbeddingsModels400Response = BadRequestResponse

--[=[
    @type ListEmbeddingsModels500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listEmbeddingsModels
]=]
export type ListEmbeddingsModels500Response = InternalServerResponse

--[=[
    @type GetGeneration200Response { data: { id: string, upstream_id: string?, total_cost: number, cache_discount: number?, upstream_inference_cost: number?, created_at: string, model: string, app_id: number?, streamed: boolean?, cancelled: boolean?, provider_name: string?, latency: number?, moderation_latency: number?, generation_time: number?, finish_reason: string?, tokens_prompt: number?, tokens_completion: number?, native_tokens_prompt: number?, native_tokens_completion: number?, native_tokens_completion_images: number?, native_tokens_reasoning: number?, native_tokens_cached: number?, num_media_prompt: number?, num_input_audio_prompt: number?, num_media_completion: number?, num_search_results: number?, origin: string, usage: number, is_byok: boolean, native_finish_reason: string?, external_user: string?, api_type: ("completions" | "embeddings")?, router: string?, provider_responses: {{ id: string?, endpoint_id: string?, model_permaslug: string?, provider_name: ("AnyScale" | "Atoma" | "Cent-ML" | "CrofAI" | "Enfer" | "GoPomelo" | "HuggingFace" | "Hyperbolic 2" | "InoCloud" | "Kluster" | "Lambda" | "Lepton" | "Lynn 2" | "Lynn" | "Mancer" | "Meta" | "Modal" | "Nineteen" | "OctoAI" | "Recursal" | "Reflection" | "Replicate" | "SambaNova 2" | "SF Compute" | "Targon" | "Together 2" | "Ubicloud" | "01.AI" | "AI21" | "AionLabs" | "Alibaba" | "Ambient" | "Amazon Bedrock" | "Amazon Nova" | "Anthropic" | "Arcee AI" | "AtlasCloud" | "Avian" | "Azure" | "BaseTen" | "BytePlus" | "Black Forest Labs" | "Cerebras" | "Chutes" | "Cirrascale" | "Clarifai" | "Cloudflare" | "Cohere" | "Crusoe" | "DeepInfra" | "DeepSeek" | "Featherless" | "Fireworks" | "Friendli" | "GMICloud" | "Google" | "Google AI Studio" | "Groq" | "Hyperbolic" | "Inception" | "Inceptron" | "InferenceNet" | "Ionstream" | "Infermatic" | "Io Net" | "Inflection" | "Liquid" | "Mara" | "Mancer 2" | "Minimax" | "ModelRun" | "Mistral" | "Modular" | "Moonshot AI" | "Morph" | "NCompass" | "Nebius" | "NextBit" | "Novita" | "Nvidia" | "OpenAI" | "OpenInference" | "Parasail" | "Perplexity" | "Phala" | "Relace" | "SambaNova" | "Seed" | "SiliconFlow" | "Sourceful" | "StepFun" | "Stealth" | "StreamLake" | "Switchpoint" | "Together" | "Upstage" | "Venice" | "WandB" | "Xiaomi" | "xAI" | "Z.AI" | "FakeProvider")?, status: number?, latency: number?, is_byok: boolean? }}? } }
    @within OpenRouterTypes
    200 Response type for getGeneration
]=]
export type GetGeneration200Response = {
	data: {
		id: string,
		upstream_id: string?,
		total_cost: number,
		cache_discount: number?,
		upstream_inference_cost: number?,
		created_at: string,
		model: string,
		app_id: number?,
		streamed: boolean?,
		cancelled: boolean?,
		provider_name: string?,
		latency: number?,
		moderation_latency: number?,
		generation_time: number?,
		finish_reason: string?,
		tokens_prompt: number?,
		tokens_completion: number?,
		native_tokens_prompt: number?,
		native_tokens_completion: number?,
		native_tokens_completion_images: number?,
		native_tokens_reasoning: number?,
		native_tokens_cached: number?,
		num_media_prompt: number?,
		num_input_audio_prompt: number?,
		num_media_completion: number?,
		num_search_results: number?,
		origin: string,
		usage: number,
		is_byok: boolean,
		native_finish_reason: string?,
		external_user: string?,
		api_type: ("completions" | "embeddings")?,
		router: string?,
		provider_responses: {
			{
				id: string?,
				endpoint_id: string?,
				model_permaslug: string?,
				provider_name: (
					"AnyScale"
					| "Atoma"
					| "Cent-ML"
					| "CrofAI"
					| "Enfer"
					| "GoPomelo"
					| "HuggingFace"
					| "Hyperbolic 2"
					| "InoCloud"
					| "Kluster"
					| "Lambda"
					| "Lepton"
					| "Lynn 2"
					| "Lynn"
					| "Mancer"
					| "Meta"
					| "Modal"
					| "Nineteen"
					| "OctoAI"
					| "Recursal"
					| "Reflection"
					| "Replicate"
					| "SambaNova 2"
					| "SF Compute"
					| "Targon"
					| "Together 2"
					| "Ubicloud"
					| "01.AI"
					| "AI21"
					| "AionLabs"
					| "Alibaba"
					| "Ambient"
					| "Amazon Bedrock"
					| "Amazon Nova"
					| "Anthropic"
					| "Arcee AI"
					| "AtlasCloud"
					| "Avian"
					| "Azure"
					| "BaseTen"
					| "BytePlus"
					| "Black Forest Labs"
					| "Cerebras"
					| "Chutes"
					| "Cirrascale"
					| "Clarifai"
					| "Cloudflare"
					| "Cohere"
					| "Crusoe"
					| "DeepInfra"
					| "DeepSeek"
					| "Featherless"
					| "Fireworks"
					| "Friendli"
					| "GMICloud"
					| "Google"
					| "Google AI Studio"
					| "Groq"
					| "Hyperbolic"
					| "Inception"
					| "Inceptron"
					| "InferenceNet"
					| "Ionstream"
					| "Infermatic"
					| "Io Net"
					| "Inflection"
					| "Liquid"
					| "Mara"
					| "Mancer 2"
					| "Minimax"
					| "ModelRun"
					| "Mistral"
					| "Modular"
					| "Moonshot AI"
					| "Morph"
					| "NCompass"
					| "Nebius"
					| "NextBit"
					| "Novita"
					| "Nvidia"
					| "OpenAI"
					| "OpenInference"
					| "Parasail"
					| "Perplexity"
					| "Phala"
					| "Relace"
					| "SambaNova"
					| "Seed"
					| "SiliconFlow"
					| "Sourceful"
					| "StepFun"
					| "Stealth"
					| "StreamLake"
					| "Switchpoint"
					| "Together"
					| "Upstage"
					| "Venice"
					| "WandB"
					| "Xiaomi"
					| "xAI"
					| "Z.AI"
					| "FakeProvider"
				)?,
				status: number?,
				latency: number?,
				is_byok: boolean?,
			}
		}?,
	},
}

--[=[
    @type GetGeneration401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getGeneration
]=]
export type GetGeneration401Response = UnauthorizedResponse

--[=[
    @type GetGeneration402Response PaymentRequiredResponse
    @within OpenRouterTypes
    402 Response type for getGeneration
]=]
export type GetGeneration402Response = PaymentRequiredResponse

--[=[
    @type GetGeneration404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for getGeneration
]=]
export type GetGeneration404Response = NotFoundResponse

--[=[
    @type GetGeneration429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for getGeneration
]=]
export type GetGeneration429Response = TooManyRequestsResponse

--[=[
    @type GetGeneration500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getGeneration
]=]
export type GetGeneration500Response = InternalServerResponse

--[=[
    @type GetGeneration502Response BadGatewayResponse
    @within OpenRouterTypes
    502 Response type for getGeneration
]=]
export type GetGeneration502Response = BadGatewayResponse

--[=[
    @type GetGeneration524Response EdgeNetworkTimeoutResponse
    @within OpenRouterTypes
    524 Response type for getGeneration
]=]
export type GetGeneration524Response = EdgeNetworkTimeoutResponse

--[=[
    @type GetGeneration529Response ProviderOverloadedResponse
    @within OpenRouterTypes
    529 Response type for getGeneration
]=]
export type GetGeneration529Response = ProviderOverloadedResponse

--[=[
    @type ListModelsCount200Response ModelsCountResponse
    @within OpenRouterTypes
    200 Response type for listModelsCount
]=]
export type ListModelsCount200Response = ModelsCountResponse

--[=[
    @type ListModelsCount500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listModelsCount
]=]
export type ListModelsCount500Response = InternalServerResponse

--[=[
    @type GetModels200Response ModelsListResponse
    @within OpenRouterTypes
    200 Response type for getModels
]=]
export type GetModels200Response = ModelsListResponse

--[=[
    @type GetModels400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for getModels
]=]
export type GetModels400Response = BadRequestResponse

--[=[
    @type GetModels500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getModels
]=]
export type GetModels500Response = InternalServerResponse

--[=[
    @type ListModelsUser200Response ModelsListResponse
    @within OpenRouterTypes
    200 Response type for listModelsUser
]=]
export type ListModelsUser200Response = ModelsListResponse

--[=[
    @type ListModelsUser401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listModelsUser
]=]
export type ListModelsUser401Response = UnauthorizedResponse

--[=[
    @type ListModelsUser404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for listModelsUser
]=]
export type ListModelsUser404Response = NotFoundResponse

--[=[
    @type ListModelsUser500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listModelsUser
]=]
export type ListModelsUser500Response = InternalServerResponse

--[=[
    @type ListEndpoints200Response { data: ListEndpointsResponse }
    @within OpenRouterTypes
    200 Response type for listEndpoints
]=]
export type ListEndpoints200Response = { data: ListEndpointsResponse }

--[=[
    @type ListEndpoints404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for listEndpoints
]=]
export type ListEndpoints404Response = NotFoundResponse

--[=[
    @type ListEndpoints500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listEndpoints
]=]
export type ListEndpoints500Response = InternalServerResponse

--[=[
    @type ListEndpointsZdr200Response { data: {PublicEndpoint} }
    @within OpenRouterTypes
    200 Response type for listEndpointsZdr
]=]
export type ListEndpointsZdr200Response = { data: { PublicEndpoint } }

--[=[
    @type ListEndpointsZdr500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listEndpointsZdr
]=]
export type ListEndpointsZdr500Response = InternalServerResponse

--[=[
    @type ListProviders200Response { data: {{ name: string, slug: string, privacy_policy_url: string?, terms_of_service_url: string?, status_page_url: string? }} }
    @within OpenRouterTypes
    200 Response type for listProviders
]=]
export type ListProviders200Response = {
	data: {
		{
			name: string,
			slug: string,
			privacy_policy_url: string?,
			terms_of_service_url: string?,
			status_page_url: string?,
		}
	},
}

--[=[
    @type ListProviders500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listProviders
]=]
export type ListProviders500Response = InternalServerResponse

--[=[
    @type List200Response { data: {{ hash: string, name: string, label: string, disabled: boolean, limit: number?, limit_remaining: number?, limit_reset: string?, include_byok_in_limit: boolean, usage: number, usage_daily: number, usage_weekly: number, usage_monthly: number, byok_usage: number, byok_usage_daily: number, byok_usage_weekly: number, byok_usage_monthly: number, created_at: string, updated_at: string?, expires_at: string? }} }
    @within OpenRouterTypes
    200 Response type for list
]=]
export type List200Response = {
	data: {
		{
			hash: string,
			name: string,
			label: string,
			disabled: boolean,
			limit: number?,
			limit_remaining: number?,
			limit_reset: string?,
			include_byok_in_limit: boolean,
			usage: number,
			usage_daily: number,
			usage_weekly: number,
			usage_monthly: number,
			byok_usage: number,
			byok_usage_daily: number,
			byok_usage_weekly: number,
			byok_usage_monthly: number,
			created_at: string,
			updated_at: string?,
			expires_at: string?,
		}
	},
}

--[=[
    @type List401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for list
]=]
export type List401Response = UnauthorizedResponse

--[=[
    @type List429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for list
]=]
export type List429Response = TooManyRequestsResponse

--[=[
    @type List500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for list
]=]
export type List500Response = InternalServerResponse

--[=[
    @type CreateKeys201Response { data: { hash: string, name: string, label: string, disabled: boolean, limit: number?, limit_remaining: number?, limit_reset: string?, include_byok_in_limit: boolean, usage: number, usage_daily: number, usage_weekly: number, usage_monthly: number, byok_usage: number, byok_usage_daily: number, byok_usage_weekly: number, byok_usage_monthly: number, created_at: string, updated_at: string?, expires_at: string? }, key: string }
    @within OpenRouterTypes
    201 Response type for createKeys
]=]
export type CreateKeys201Response = {
	data: {
		hash: string,
		name: string,
		label: string,
		disabled: boolean,
		limit: number?,
		limit_remaining: number?,
		limit_reset: string?,
		include_byok_in_limit: boolean,
		usage: number,
		usage_daily: number,
		usage_weekly: number,
		usage_monthly: number,
		byok_usage: number,
		byok_usage_daily: number,
		byok_usage_weekly: number,
		byok_usage_monthly: number,
		created_at: string,
		updated_at: string?,
		expires_at: string?,
	},
	key: string,
}

--[=[
    @type CreateKeys400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createKeys
]=]
export type CreateKeys400Response = BadRequestResponse

--[=[
    @type CreateKeys401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createKeys
]=]
export type CreateKeys401Response = UnauthorizedResponse

--[=[
    @type CreateKeys429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for createKeys
]=]
export type CreateKeys429Response = TooManyRequestsResponse

--[=[
    @type CreateKeys500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createKeys
]=]
export type CreateKeys500Response = InternalServerResponse

--[=[
    @type GetKey200Response { data: { hash: string, name: string, label: string, disabled: boolean, limit: number?, limit_remaining: number?, limit_reset: string?, include_byok_in_limit: boolean, usage: number, usage_daily: number, usage_weekly: number, usage_monthly: number, byok_usage: number, byok_usage_daily: number, byok_usage_weekly: number, byok_usage_monthly: number, created_at: string, updated_at: string?, expires_at: string? } }
    @within OpenRouterTypes
    200 Response type for getKey
]=]
export type GetKey200Response = {
	data: {
		hash: string,
		name: string,
		label: string,
		disabled: boolean,
		limit: number?,
		limit_remaining: number?,
		limit_reset: string?,
		include_byok_in_limit: boolean,
		usage: number,
		usage_daily: number,
		usage_weekly: number,
		usage_monthly: number,
		byok_usage: number,
		byok_usage_daily: number,
		byok_usage_weekly: number,
		byok_usage_monthly: number,
		created_at: string,
		updated_at: string?,
		expires_at: string?,
	},
}

--[=[
    @type GetKey401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getKey
]=]
export type GetKey401Response = UnauthorizedResponse

--[=[
    @type GetKey404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for getKey
]=]
export type GetKey404Response = NotFoundResponse

--[=[
    @type GetKey429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for getKey
]=]
export type GetKey429Response = TooManyRequestsResponse

--[=[
    @type GetKey500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getKey
]=]
export type GetKey500Response = InternalServerResponse

--[=[
    @type DeleteKeys200Response { deleted: boolean }
    @within OpenRouterTypes
    200 Response type for deleteKeys
]=]
export type DeleteKeys200Response = { deleted: boolean }

--[=[
    @type DeleteKeys401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for deleteKeys
]=]
export type DeleteKeys401Response = UnauthorizedResponse

--[=[
    @type DeleteKeys404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for deleteKeys
]=]
export type DeleteKeys404Response = NotFoundResponse

--[=[
    @type DeleteKeys429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for deleteKeys
]=]
export type DeleteKeys429Response = TooManyRequestsResponse

--[=[
    @type DeleteKeys500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for deleteKeys
]=]
export type DeleteKeys500Response = InternalServerResponse

--[=[
    @type UpdateKeys200Response { data: { hash: string, name: string, label: string, disabled: boolean, limit: number?, limit_remaining: number?, limit_reset: string?, include_byok_in_limit: boolean, usage: number, usage_daily: number, usage_weekly: number, usage_monthly: number, byok_usage: number, byok_usage_daily: number, byok_usage_weekly: number, byok_usage_monthly: number, created_at: string, updated_at: string?, expires_at: string? } }
    @within OpenRouterTypes
    200 Response type for updateKeys
]=]
export type UpdateKeys200Response = {
	data: {
		hash: string,
		name: string,
		label: string,
		disabled: boolean,
		limit: number?,
		limit_remaining: number?,
		limit_reset: string?,
		include_byok_in_limit: boolean,
		usage: number,
		usage_daily: number,
		usage_weekly: number,
		usage_monthly: number,
		byok_usage: number,
		byok_usage_daily: number,
		byok_usage_weekly: number,
		byok_usage_monthly: number,
		created_at: string,
		updated_at: string?,
		expires_at: string?,
	},
}

--[=[
    @type UpdateKeys400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for updateKeys
]=]
export type UpdateKeys400Response = BadRequestResponse

--[=[
    @type UpdateKeys401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for updateKeys
]=]
export type UpdateKeys401Response = UnauthorizedResponse

--[=[
    @type UpdateKeys404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for updateKeys
]=]
export type UpdateKeys404Response = NotFoundResponse

--[=[
    @type UpdateKeys429Response TooManyRequestsResponse
    @within OpenRouterTypes
    429 Response type for updateKeys
]=]
export type UpdateKeys429Response = TooManyRequestsResponse

--[=[
    @type UpdateKeys500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for updateKeys
]=]
export type UpdateKeys500Response = InternalServerResponse

--[=[
    @type ListGuardrails200Response { data: {{ id: string, name: string, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean?, created_at: string, updated_at: string? }}, total_count: number }
    @within OpenRouterTypes
    200 Response type for listGuardrails
]=]
export type ListGuardrails200Response = {
	data: {
		{
			id: string,
			name: string,
			description: string?,
			limit_usd: number?,
			reset_interval: ("daily" | "weekly" | "monthly")?,
			allowed_providers: { string }?,
			allowed_models: { string }?,
			enforce_zdr: boolean?,
			created_at: string,
			updated_at: string?,
		}
	},
	total_count: number,
}

--[=[
    @type ListGuardrails401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listGuardrails
]=]
export type ListGuardrails401Response = UnauthorizedResponse

--[=[
    @type ListGuardrails500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listGuardrails
]=]
export type ListGuardrails500Response = InternalServerResponse

--[=[
    @type CreateGuardrail201Response { data: { id: string, name: string, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean?, created_at: string, updated_at: string? } }
    @within OpenRouterTypes
    201 Response type for createGuardrail
]=]
export type CreateGuardrail201Response = {
	data: {
		id: string,
		name: string,
		description: string?,
		limit_usd: number?,
		reset_interval: ("daily" | "weekly" | "monthly")?,
		allowed_providers: { string }?,
		allowed_models: { string }?,
		enforce_zdr: boolean?,
		created_at: string,
		updated_at: string?,
	},
}

--[=[
    @type CreateGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createGuardrail
]=]
export type CreateGuardrail400Response = BadRequestResponse

--[=[
    @type CreateGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createGuardrail
]=]
export type CreateGuardrail401Response = UnauthorizedResponse

--[=[
    @type CreateGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createGuardrail
]=]
export type CreateGuardrail500Response = InternalServerResponse

--[=[
    @type GetGuardrail200Response { data: { id: string, name: string, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean?, created_at: string, updated_at: string? } }
    @within OpenRouterTypes
    200 Response type for getGuardrail
]=]
export type GetGuardrail200Response = {
	data: {
		id: string,
		name: string,
		description: string?,
		limit_usd: number?,
		reset_interval: ("daily" | "weekly" | "monthly")?,
		allowed_providers: { string }?,
		allowed_models: { string }?,
		enforce_zdr: boolean?,
		created_at: string,
		updated_at: string?,
	},
}

--[=[
    @type GetGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getGuardrail
]=]
export type GetGuardrail401Response = UnauthorizedResponse

--[=[
    @type GetGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for getGuardrail
]=]
export type GetGuardrail404Response = NotFoundResponse

--[=[
    @type GetGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getGuardrail
]=]
export type GetGuardrail500Response = InternalServerResponse

--[=[
    @type DeleteGuardrail200Response { deleted: boolean }
    @within OpenRouterTypes
    200 Response type for deleteGuardrail
]=]
export type DeleteGuardrail200Response = { deleted: boolean }

--[=[
    @type DeleteGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for deleteGuardrail
]=]
export type DeleteGuardrail401Response = UnauthorizedResponse

--[=[
    @type DeleteGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for deleteGuardrail
]=]
export type DeleteGuardrail404Response = NotFoundResponse

--[=[
    @type DeleteGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for deleteGuardrail
]=]
export type DeleteGuardrail500Response = InternalServerResponse

--[=[
    @type UpdateGuardrail200Response { data: { id: string, name: string, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean?, created_at: string, updated_at: string? } }
    @within OpenRouterTypes
    200 Response type for updateGuardrail
]=]
export type UpdateGuardrail200Response = {
	data: {
		id: string,
		name: string,
		description: string?,
		limit_usd: number?,
		reset_interval: ("daily" | "weekly" | "monthly")?,
		allowed_providers: { string }?,
		allowed_models: { string }?,
		enforce_zdr: boolean?,
		created_at: string,
		updated_at: string?,
	},
}

--[=[
    @type UpdateGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for updateGuardrail
]=]
export type UpdateGuardrail400Response = BadRequestResponse

--[=[
    @type UpdateGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for updateGuardrail
]=]
export type UpdateGuardrail401Response = UnauthorizedResponse

--[=[
    @type UpdateGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for updateGuardrail
]=]
export type UpdateGuardrail404Response = NotFoundResponse

--[=[
    @type UpdateGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for updateGuardrail
]=]
export type UpdateGuardrail500Response = InternalServerResponse

--[=[
    @type ListKeyAssignments200Response { data: {{ id: string, key_hash: string, guardrail_id: string, key_name: string, key_label: string, assigned_by: string?, created_at: string }}, total_count: number }
    @within OpenRouterTypes
    200 Response type for listKeyAssignments
]=]
export type ListKeyAssignments200Response = {
	data: {
		{
			id: string,
			key_hash: string,
			guardrail_id: string,
			key_name: string,
			key_label: string,
			assigned_by: string?,
			created_at: string,
		}
	},
	total_count: number,
}

--[=[
    @type ListKeyAssignments401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listKeyAssignments
]=]
export type ListKeyAssignments401Response = UnauthorizedResponse

--[=[
    @type ListKeyAssignments500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listKeyAssignments
]=]
export type ListKeyAssignments500Response = InternalServerResponse

--[=[
    @type ListMemberAssignments200Response { data: {{ id: string, user_id: string, organization_id: string, guardrail_id: string, assigned_by: string?, created_at: string }}, total_count: number }
    @within OpenRouterTypes
    200 Response type for listMemberAssignments
]=]
export type ListMemberAssignments200Response = {
	data: {
		{
			id: string,
			user_id: string,
			organization_id: string,
			guardrail_id: string,
			assigned_by: string?,
			created_at: string,
		}
	},
	total_count: number,
}

--[=[
    @type ListMemberAssignments401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listMemberAssignments
]=]
export type ListMemberAssignments401Response = UnauthorizedResponse

--[=[
    @type ListMemberAssignments500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listMemberAssignments
]=]
export type ListMemberAssignments500Response = InternalServerResponse

--[=[
    @type ListGuardrailKeyAssignments200Response { data: {{ id: string, key_hash: string, guardrail_id: string, key_name: string, key_label: string, assigned_by: string?, created_at: string }}, total_count: number }
    @within OpenRouterTypes
    200 Response type for listGuardrailKeyAssignments
]=]
export type ListGuardrailKeyAssignments200Response = {
	data: {
		{
			id: string,
			key_hash: string,
			guardrail_id: string,
			key_name: string,
			key_label: string,
			assigned_by: string?,
			created_at: string,
		}
	},
	total_count: number,
}

--[=[
    @type ListGuardrailKeyAssignments401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listGuardrailKeyAssignments
]=]
export type ListGuardrailKeyAssignments401Response = UnauthorizedResponse

--[=[
    @type ListGuardrailKeyAssignments404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for listGuardrailKeyAssignments
]=]
export type ListGuardrailKeyAssignments404Response = NotFoundResponse

--[=[
    @type ListGuardrailKeyAssignments500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listGuardrailKeyAssignments
]=]
export type ListGuardrailKeyAssignments500Response = InternalServerResponse

--[=[
    @type BulkAssignKeysToGuardrail200Response { assigned_count: number }
    @within OpenRouterTypes
    200 Response type for bulkAssignKeysToGuardrail
]=]
export type BulkAssignKeysToGuardrail200Response = { assigned_count: number }

--[=[
    @type BulkAssignKeysToGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for bulkAssignKeysToGuardrail
]=]
export type BulkAssignKeysToGuardrail400Response = BadRequestResponse

--[=[
    @type BulkAssignKeysToGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for bulkAssignKeysToGuardrail
]=]
export type BulkAssignKeysToGuardrail401Response = UnauthorizedResponse

--[=[
    @type BulkAssignKeysToGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for bulkAssignKeysToGuardrail
]=]
export type BulkAssignKeysToGuardrail404Response = NotFoundResponse

--[=[
    @type BulkAssignKeysToGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for bulkAssignKeysToGuardrail
]=]
export type BulkAssignKeysToGuardrail500Response = InternalServerResponse

--[=[
    @type ListGuardrailMemberAssignments200Response { data: {{ id: string, user_id: string, organization_id: string, guardrail_id: string, assigned_by: string?, created_at: string }}, total_count: number }
    @within OpenRouterTypes
    200 Response type for listGuardrailMemberAssignments
]=]
export type ListGuardrailMemberAssignments200Response = {
	data: {
		{
			id: string,
			user_id: string,
			organization_id: string,
			guardrail_id: string,
			assigned_by: string?,
			created_at: string,
		}
	},
	total_count: number,
}

--[=[
    @type ListGuardrailMemberAssignments401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for listGuardrailMemberAssignments
]=]
export type ListGuardrailMemberAssignments401Response = UnauthorizedResponse

--[=[
    @type ListGuardrailMemberAssignments404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for listGuardrailMemberAssignments
]=]
export type ListGuardrailMemberAssignments404Response = NotFoundResponse

--[=[
    @type ListGuardrailMemberAssignments500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for listGuardrailMemberAssignments
]=]
export type ListGuardrailMemberAssignments500Response = InternalServerResponse

--[=[
    @type BulkAssignMembersToGuardrail200Response { assigned_count: number }
    @within OpenRouterTypes
    200 Response type for bulkAssignMembersToGuardrail
]=]
export type BulkAssignMembersToGuardrail200Response = { assigned_count: number }

--[=[
    @type BulkAssignMembersToGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for bulkAssignMembersToGuardrail
]=]
export type BulkAssignMembersToGuardrail400Response = BadRequestResponse

--[=[
    @type BulkAssignMembersToGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for bulkAssignMembersToGuardrail
]=]
export type BulkAssignMembersToGuardrail401Response = UnauthorizedResponse

--[=[
    @type BulkAssignMembersToGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for bulkAssignMembersToGuardrail
]=]
export type BulkAssignMembersToGuardrail404Response = NotFoundResponse

--[=[
    @type BulkAssignMembersToGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for bulkAssignMembersToGuardrail
]=]
export type BulkAssignMembersToGuardrail500Response = InternalServerResponse

--[=[
    @type BulkUnassignKeysFromGuardrail200Response { unassigned_count: number }
    @within OpenRouterTypes
    200 Response type for bulkUnassignKeysFromGuardrail
]=]
export type BulkUnassignKeysFromGuardrail200Response = { unassigned_count: number }

--[=[
    @type BulkUnassignKeysFromGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for bulkUnassignKeysFromGuardrail
]=]
export type BulkUnassignKeysFromGuardrail400Response = BadRequestResponse

--[=[
    @type BulkUnassignKeysFromGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for bulkUnassignKeysFromGuardrail
]=]
export type BulkUnassignKeysFromGuardrail401Response = UnauthorizedResponse

--[=[
    @type BulkUnassignKeysFromGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for bulkUnassignKeysFromGuardrail
]=]
export type BulkUnassignKeysFromGuardrail404Response = NotFoundResponse

--[=[
    @type BulkUnassignKeysFromGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for bulkUnassignKeysFromGuardrail
]=]
export type BulkUnassignKeysFromGuardrail500Response = InternalServerResponse

--[=[
    @type BulkUnassignMembersFromGuardrail200Response { unassigned_count: number }
    @within OpenRouterTypes
    200 Response type for bulkUnassignMembersFromGuardrail
]=]
export type BulkUnassignMembersFromGuardrail200Response = { unassigned_count: number }

--[=[
    @type BulkUnassignMembersFromGuardrail400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for bulkUnassignMembersFromGuardrail
]=]
export type BulkUnassignMembersFromGuardrail400Response = BadRequestResponse

--[=[
    @type BulkUnassignMembersFromGuardrail401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for bulkUnassignMembersFromGuardrail
]=]
export type BulkUnassignMembersFromGuardrail401Response = UnauthorizedResponse

--[=[
    @type BulkUnassignMembersFromGuardrail404Response NotFoundResponse
    @within OpenRouterTypes
    404 Response type for bulkUnassignMembersFromGuardrail
]=]
export type BulkUnassignMembersFromGuardrail404Response = NotFoundResponse

--[=[
    @type BulkUnassignMembersFromGuardrail500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for bulkUnassignMembersFromGuardrail
]=]
export type BulkUnassignMembersFromGuardrail500Response = InternalServerResponse

--[=[
    @type GetCurrentKey200Response { data: { label: string, limit: number?, usage: number, usage_daily: number, usage_weekly: number, usage_monthly: number, byok_usage: number, byok_usage_daily: number, byok_usage_weekly: number, byok_usage_monthly: number, is_free_tier: boolean, is_management_key: boolean, is_provisioning_key: boolean, limit_remaining: number?, limit_reset: string?, include_byok_in_limit: boolean, expires_at: string?, rate_limit: { requests: number, interval: string, note: string } } }
    @within OpenRouterTypes
    200 Response type for getCurrentKey
]=]
export type GetCurrentKey200Response = {
	data: {
		label: string,
		limit: number?,
		usage: number,
		usage_daily: number,
		usage_weekly: number,
		usage_monthly: number,
		byok_usage: number,
		byok_usage_daily: number,
		byok_usage_weekly: number,
		byok_usage_monthly: number,
		is_free_tier: boolean,
		is_management_key: boolean,
		is_provisioning_key: boolean,
		limit_remaining: number?,
		limit_reset: string?,
		include_byok_in_limit: boolean,
		expires_at: string?,
		rate_limit: { requests: number, interval: string, note: string },
	},
}

--[=[
    @type GetCurrentKey401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for getCurrentKey
]=]
export type GetCurrentKey401Response = UnauthorizedResponse

--[=[
    @type GetCurrentKey500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for getCurrentKey
]=]
export type GetCurrentKey500Response = InternalServerResponse

--[=[
    @type ExchangeAuthCodeForAPIKey200Response { key: string, user_id: string? }
    @within OpenRouterTypes
    200 Response type for exchangeAuthCodeForAPIKey
]=]
export type ExchangeAuthCodeForAPIKey200Response = { key: string, user_id: string? }

--[=[
    @type ExchangeAuthCodeForAPIKey400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for exchangeAuthCodeForAPIKey
]=]
export type ExchangeAuthCodeForAPIKey400Response = BadRequestResponse

--[=[
    @type ExchangeAuthCodeForAPIKey403Response ForbiddenResponse
    @within OpenRouterTypes
    403 Response type for exchangeAuthCodeForAPIKey
]=]
export type ExchangeAuthCodeForAPIKey403Response = ForbiddenResponse

--[=[
    @type ExchangeAuthCodeForAPIKey500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for exchangeAuthCodeForAPIKey
]=]
export type ExchangeAuthCodeForAPIKey500Response = InternalServerResponse

--[=[
    @type CreateAuthKeysCode200Response { data: { id: string, app_id: number, created_at: string } }
    @within OpenRouterTypes
    200 Response type for createAuthKeysCode
]=]
export type CreateAuthKeysCode200Response = { data: { id: string, app_id: number, created_at: string } }

--[=[
    @type CreateAuthKeysCode400Response BadRequestResponse
    @within OpenRouterTypes
    400 Response type for createAuthKeysCode
]=]
export type CreateAuthKeysCode400Response = BadRequestResponse

--[=[
    @type CreateAuthKeysCode401Response UnauthorizedResponse
    @within OpenRouterTypes
    401 Response type for createAuthKeysCode
]=]
export type CreateAuthKeysCode401Response = UnauthorizedResponse

--[=[
    @type CreateAuthKeysCode500Response InternalServerResponse
    @within OpenRouterTypes
    500 Response type for createAuthKeysCode
]=]
export type CreateAuthKeysCode500Response = InternalServerResponse
return {}

--!strict
-- This file is auto-generated from OpenRouter API
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: 2025-11-06T23:35:09.169101Z

--[[
  OpenAI-compatible Chat Completions and Completions API with additional
  OpenRouter features
]]

export type ResultOk<T> = { type: "ok", value: T } -- Request succeeded
export type ResultErr<E> = { type: "err", error: E } -- Request responded with an error
export type ResultCrash = { type: "crash", error: string } -- Request failed to send
export type Result<T, E> = ResultOk<T> | ResultErr<E> | ResultCrash

export type HttpMethod = "GET" | "HEAD" | "POST" | "PUT" | "DELETE" | "OPTIONS" | "TRACE" | "PATCH"

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

export type AssistantMessage = {
	role: string,
	content: ((string | { ChatMessageContentItem }) | nil)?,
	name: string?,
	tool_calls: { ChatMessageToolCall }?,
	refusal: (string | nil)?,
	reasoning: (string | nil)?,
}

--[[
  Bad Gateway - Provider/upstream API failure
]]
export type BadGatewayResponse = { error: BadGatewayResponseErrorData, user_id: string? }

--[[
  Error data for BadGatewayResponse
]]
export type BadGatewayResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  Bad Request - Invalid request parameters or malformed input
]]
export type BadRequestResponse = { error: BadRequestResponseErrorData, user_id: string? }

--[[
  Error data for BadRequestResponse
]]
export type BadRequestResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  A value in string or number format that is a large number
]]
export type BigNumberUnion = number | string

export type ChatCompletionFinishReason = "tool_calls" | "stop" | "length" | "content_filter" | "error"

export type ChatError = {
	error: { code: string | number | nil, message: string, param: (string | nil)?, ["type"]: (string | nil)? },
}

export type ChatGenerationParams = {
	messages: { Message },
	model: ModelName?,
	models: { ModelName }?,
	frequency_penalty: (number | nil)?,
	logit_bias: ({ [string]: number } | nil)?,
	logprobs: (boolean | nil)?,
	top_logprobs: (number | nil)?,
	max_completion_tokens: (number | nil)?,
	max_tokens: (number | nil)?,
	metadata: { [string]: string }?,
	presence_penalty: (number | nil)?,
	reasoning: { effort: (("minimal" | "low" | "medium" | "high") | nil)?, summary: (ReasoningSummaryVerbosity | nil)? }?,
	response_format: ({ ["type"]: string } | ResponseFormatJSONSchema | ResponseFormatTextGrammar)?,
	seed: (number | nil)?,
	stop: ((string | { string }) | nil)?,
	stream: boolean?,
	stream_options: (ChatStreamOptions | nil)?,
	temperature: (number | nil)?,
	tool_choice: ToolChoiceOption?,
	tools: { ToolDefinitionJson }?,
	top_p: (number | nil)?,
	user: string?,
}

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
	prompt_tokens_details: ({ cached_tokens: number?, audio_tokens: number? } | nil)?,
}

export type ChatMessageContentItem = (
	ChatMessageContentItemText | ChatMessageContentItemImage | ChatMessageContentItemAudio | ChatMessageContentItemVideo
)

export type ChatMessageContentItemAudio = {
	["type"]: string,
	input_audio: { data: string, format: "wav" | "mp3" | "flac" | "m4a" | "ogg" | "pcm16" | "pcm24" },
}

export type ChatMessageContentItemImage = {
	["type"]: string,
	image_url: { url: string, detail: ("auto" | "low" | "high")? },
}

export type ChatMessageContentItemText = { ["type"]: string, text: string }

export type ChatMessageContentItemVideo = { ["type"]: string, video_url: { url: string } }

export type ChatMessageTokenLogprob = {
	token: string,
	logprob: number,
	bytes: { number } | nil,
	top_logprobs: { { token: string, logprob: number, bytes: { number } | nil } },
}

export type ChatMessageTokenLogprobs = {
	content: { ChatMessageTokenLogprob } | nil,
	refusal: { ChatMessageTokenLogprob } | nil,
}

export type ChatMessageToolCall = { id: string, ["type"]: string, ["function"]: { name: string, arguments: string } }

export type ChatResponse = {
	id: string,
	choices: { ChatResponseChoice },
	created: number,
	model: string,
	object: string,
	system_fingerprint: (string | nil)?,
	usage: ChatGenerationTokenUsage?,
}

export type ChatResponseChoice = {
	finish_reason: __schema0,
	index: number,
	message: AssistantMessage,
	logprobs: (ChatMessageTokenLogprobs | nil)?,
}

export type ChatStreamOptions = { include_usage: boolean? }

export type ChatStreamingChoice = {
	delta: ChatStreamingMessageChunk,
	finish_reason: __schema0,
	index: number,
	logprobs: (ChatMessageTokenLogprobs | nil)?,
}

export type ChatStreamingMessageChunk = {
	role: "assistant"?,
	content: (string | nil)?,
	reasoning: (string | nil)?,
	refusal: (string | nil)?,
	tool_calls: { ChatStreamingMessageToolCall }?,
}

export type ChatStreamingMessageToolCall = {
	index: number,
	id: string?,
	["type"]: string?,
	["function"]: { name: string?, arguments: string? }?,
}

export type ChatStreamingResponseChunk = {
	data: {
		id: string,
		choices: { ChatStreamingChoice },
		created: number,
		model: string,
		object: string,
		system_fingerprint: (string | nil)?,
		error: { message: string, code: number }?,
		usage: ChatGenerationTokenUsage?,
	},
}

export type CompletionChoice = {
	text: string,
	index: number,
	logprobs: CompletionLogprobs | nil,
	finish_reason: CompletionFinishReason,
}

export type CompletionCreateParams = {
	model: ModelName?,
	models: { ModelName }?,
	prompt: string | { string } | { number } | { { number } },
	best_of: (number | nil)?,
	echo: (boolean | nil)?,
	frequency_penalty: (number | nil)?,
	logit_bias: ({ [string]: number } | nil)?,
	logprobs: (number | nil)?,
	max_tokens: (number | nil)?,
	n: (number | nil)?,
	presence_penalty: (number | nil)?,
	seed: (number | nil)?,
	stop: ((string | { string }) | nil)?,
	stream: boolean?,
	stream_options: ({ include_usage: (boolean | nil)? } | nil)?,
	suffix: (string | nil)?,
	temperature: (number | nil)?,
	top_p: (number | nil)?,
	user: string?,
	metadata: ({ [string]: string } | nil)?,
	response_format: (({ ["type"]: string } | ResponseFormatJSONSchema | ResponseFormatTextGrammar) | nil)?,
}

export type CompletionFinishReason = "stop" | "length" | "content_filter" | nil

export type CompletionLogprobs = {
	tokens: { string },
	token_logprobs: { number },
	top_logprobs: { { [string]: number } } | nil,
	text_offset: { number },
}

export type CompletionResponse = {
	id: string,
	object: string,
	created: number,
	model: string,
	system_fingerprint: string?,
	choices: { CompletionChoice },
	usage: CompletionUsage?,
}

export type CompletionUsage = { prompt_tokens: number, completion_tokens: number, total_tokens: number }

--[[
  Create a Coinbase charge for crypto payment
]]
export type CreateChargeRequest = { amount: number, sender: string, chain_id: number }

--[[
  Default parameters for this model
]]
export type DefaultParameters = { temperature: number?, top_p: number?, frequency_penalty: number? }?

--[[
  Infrastructure Timeout - Provider request timed out at edge network
]]
export type EdgeNetworkTimeoutResponse = { error: EdgeNetworkTimeoutResponseErrorData, user_id: string? }

--[[
  Error data for EdgeNetworkTimeoutResponse
]]
export type EdgeNetworkTimeoutResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type EndpointStatus = number

export type FileCitation = { ["type"]: "file_citation", file_id: string, filename: string, index: number }

export type FilePath = { ["type"]: "file_path", file_id: string, index: number }

--[[
  Forbidden - Authentication successful but insufficient permissions
]]
export type ForbiddenResponse = { error: ForbiddenResponseErrorData, user_id: string? }

--[[
  Error data for ForbiddenResponse
]]
export type ForbiddenResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type ImageGenerationStatus = "in_progress" | "completed" | "generating" | "failed"

export type InputModality = "text" | "image" | "file" | "audio" | "video"

--[[
  Instruction format type
]]
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

--[[
  Internal Server Error - Unexpected server error
]]
export type InternalServerResponse = { error: InternalServerResponseErrorData, user_id: string? }

--[[
  Error data for InternalServerResponse
]]
export type InternalServerResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type JSONSchemaConfig = {
	name: string,
	description: string?,
	schema: { [string]: any }?,
	strict: (boolean | nil)?,
}

--[[
  List of available endpoints for a model
]]
export type ListEndpointsResponse = {
	id: string,
	name: string,
	created: number,
	description: string,
	architecture: ModelArchitecture & {
		tokenizer: (ModelGroup & any)?,
		instruct_type: InstructType,
		modality: string?,
		input_modalities: { InputModality },
		output_modalities: { OutputModality },
	},
	endpoints: { PublicEndpoint },
}

export type Message = (
	SystemMessage
	| UserMessage
	| { role: string, content: string | { ChatMessageContentItemText }, name: string? }
	| AssistantMessage
	| ToolResponseMessage
)

--[[
  Information about an AI model available on OpenRouter
]]
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
}

--[[
  Model architecture information
]]
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

--[[
  Tokenizer type used by the model
]]
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

export type ModelName = string

--[[
  Model count data
]]
export type ModelsCountResponse = { data: { count: number } }

--[[
  List of available models
]]
export type ModelsListResponse = { data: ModelsListResponseData }

--[[
  List of available models
]]
export type ModelsListResponseData = { Model }

export type NamedToolChoice = { ["type"]: string, ["function"]: { name: string } }

--[[
  Not Found - Resource does not exist
]]
export type NotFoundResponse = { error: NotFoundResponseErrorData, user_id: string? }

--[[
  Error data for NotFoundResponse
]]
export type NotFoundResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type OpenAIResponsesAnnotation = FileCitation | URLCitation | FilePath

--[[
  Event emitted when an error occurs during streaming
]]
export type OpenAIResponsesErrorEvent = {
	["type"]: "error",
	code: string?,
	message: string,
	param: string?,
	sequence_number: number,
}

export type OpenAIResponsesImageGenCallCompleted = {
	["type"]: "response.image_generation_call.completed",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

export type OpenAIResponsesImageGenCallGenerating = {
	["type"]: "response.image_generation_call.generating",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

export type OpenAIResponsesImageGenCallInProgress = {
	["type"]: "response.image_generation_call.in_progress",
	item_id: string,
	output_index: number,
	sequence_number: number,
}

export type OpenAIResponsesImageGenCallPartialImage = {
	["type"]: "response.image_generation_call.partial_image",
	item_id: string,
	output_index: number,
	sequence_number: number,
	partial_image_b64: string,
	partial_image_index: number,
}

export type OpenAIResponsesIncludable = (
	"file_search_call.results"
	| "message.input_image.image_url"
	| "computer_call_output.output.image_url"
	| "reasoning.encrypted_content"
	| "code_interpreter_call.outputs"
)

export type OpenAIResponsesIncompleteDetails = { reason: ("max_output_tokens" | "content_filter")? }?

export type OpenAIResponsesInput =
	string
	| {
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
			id: string,
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
	}
	| any?

export type OpenAIResponsesNonStreamingResponse = {
	id: string,
	object: "response",
	created_at: number,
	model: string,
	status: OpenAIResponsesResponseStatus?,
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

export type OpenAIResponsesPrompt = {
	id: string,
	variables: { [string]: string | ResponseInputText | ResponseInputImage | ResponseInputFile }?,
}?

export type OpenAIResponsesReasoningConfig = {
	effort: OpenAIResponsesReasoningEffort?,
	summary: ReasoningSummaryVerbosity?,
}?

--[[
  Event emitted when reasoning text delta is streamed
]]
export type OpenAIResponsesReasoningDeltaEvent = {
	["type"]: "response.reasoning_text.delta",
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[[
  Event emitted when reasoning text streaming is complete
]]
export type OpenAIResponsesReasoningDoneEvent = {
	["type"]: "response.reasoning_text.done",
	output_index: number,
	item_id: string,
	content_index: number,
	text: string,
	sequence_number: number,
}

export type OpenAIResponsesReasoningEffort = ("high" | "medium" | "low" | "minimal")?

--[[
  Event emitted when a reasoning summary part is added
]]
export type OpenAIResponsesReasoningSummaryPartAddedEvent = {
	["type"]: "response.reasoning_summary_part.added",
	output_index: number,
	item_id: string,
	summary_index: number,
	part: ReasoningSummaryText,
	sequence_number: number,
}

--[[
  Event emitted when reasoning summary text delta is streamed
]]
export type OpenAIResponsesReasoningSummaryTextDeltaEvent = {
	["type"]: "response.reasoning_summary_text.delta",
	item_id: string,
	output_index: number,
	summary_index: number,
	delta: string,
	sequence_number: number,
}

--[[
  Event emitted when reasoning summary text streaming is complete
]]
export type OpenAIResponsesReasoningSummaryTextDoneEvent = {
	["type"]: "response.reasoning_summary_text.done",
	item_id: string,
	output_index: number,
	summary_index: number,
	text: string,
	sequence_number: number,
}

export type OpenAIResponsesRefusalContent = { ["type"]: "refusal", refusal: string }

export type OpenAIResponsesResponseStatus = (
	"completed" | "incomplete" | "in_progress" | "failed" | "cancelled" | "queued"
)

export type OpenAIResponsesServiceTier = ("auto" | "default" | "flex" | "priority" | "scale")?

export type OpenAIResponsesToolChoice = "auto" | "none" | "required" | { ["type"]: "function", name: string } | {
	["type"]: "web_search_preview_2025_03_11" | "web_search_preview",
}

export type OpenAIResponsesTruncation = ("auto" | "disabled")?

export type OpenAIResponsesUsage = {
	input_tokens: number,
	input_tokens_details: { cached_tokens: number },
	output_tokens: number,
	output_tokens_details: { reasoning_tokens: number },
	total_tokens: number,
}

--[[
  Event emitted when a response has completed successfully
]]
export type OpenResponsesCompletedEvent = {
	["type"]: "response.completed",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[[
  Event emitted when a new content part is added to an output item
]]
export type OpenResponsesContentPartAddedEvent = {
	["type"]: "response.content_part.added",
	output_index: number,
	item_id: string,
	content_index: number,
	part: ResponseOutputText | OpenAIResponsesRefusalContent,
	sequence_number: number,
}

--[[
  Event emitted when a content part is complete
]]
export type OpenResponsesContentPartDoneEvent = {
	["type"]: "response.content_part.done",
	output_index: number,
	item_id: string,
	content_index: number,
	part: ResponseOutputText | OpenAIResponsesRefusalContent,
	sequence_number: number,
}

--[[
  Event emitted when a response is created
]]
export type OpenResponsesCreatedEvent = {
	["type"]: "response.created",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

export type OpenResponsesEasyInputMessage = {
	["type"]: "message"?,
	role: "user" | "system" | "assistant" | "developer",
	content: { ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio } | string,
}

--[[
  Event emitted when an error occurs during streaming
]]
export type OpenResponsesErrorEvent = OpenAIResponsesErrorEvent

--[[
  Event emitted when a response has failed
]]
export type OpenResponsesFailedEvent = {
	["type"]: "response.failed",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[[
  Event emitted when function call arguments are being streamed
]]
export type OpenResponsesFunctionCallArgumentsDeltaEvent = {
	["type"]: "response.function_call_arguments.delta",
	item_id: string,
	output_index: number,
	delta: string,
	sequence_number: number,
}

--[[
  Event emitted when function call arguments streaming is complete
]]
export type OpenResponsesFunctionCallArgumentsDoneEvent = {
	["type"]: "response.function_call_arguments.done",
	item_id: string,
	output_index: number,
	name: string,
	arguments: string,
	sequence_number: number,
}

--[[
  The output from a function call execution
]]
export type OpenResponsesFunctionCallOutput = {
	["type"]: "function_call_output",
	id: string,
	call_id: string,
	output: string,
	status: ToolCallStatus?,
}

--[[
  Function tool definition
]]
export type OpenResponsesFunctionTool = {
	["type"]: "function",
	name: string,
	description: string?,
	strict: boolean?,
	parameters: { [string]: any? }?,
}

--[[
  A function call initiated by the model
]]
export type OpenResponsesFunctionToolCall = {
	["type"]: "function_call",
	call_id: string,
	name: string,
	arguments: string,
	id: string,
	status: ToolCallStatus?,
}

--[[
  Image generation call completed
]]
export type OpenResponsesImageGenCallCompleted = OpenAIResponsesImageGenCallCompleted

--[[
  Image generation call is generating
]]
export type OpenResponsesImageGenCallGenerating = OpenAIResponsesImageGenCallGenerating

--[[
  Image generation call in progress
]]
export type OpenResponsesImageGenCallInProgress = OpenAIResponsesImageGenCallInProgress

--[[
  Image generation call with partial image
]]
export type OpenResponsesImageGenCallPartialImage = OpenAIResponsesImageGenCallPartialImage

--[[
  Event emitted when a response is in progress
]]
export type OpenResponsesInProgressEvent = {
	["type"]: "response.in_progress",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[[
  Event emitted when a response is incomplete
]]
export type OpenResponsesIncompleteEvent = {
	["type"]: "response.incomplete",
	response: OpenAIResponsesNonStreamingResponse,
	sequence_number: number,
}

--[[
  Input for a response request - can be a string or array of items
]]
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

export type OpenResponsesInputMessageItem = {
	id: string?,
	["type"]: "message"?,
	role: "user" | "system" | "developer",
	content: { ResponseInputText | ResponseInputImage | ResponseInputFile | ResponseInputAudio },
}

--[[
  Log probability information for a token
]]
export type OpenResponsesLogProbs = { logprob: number, token: string, top_logprobs: { OpenResponsesTopLogprobs }? }

--[[
  Complete non-streaming response from the Responses API
]]
export type OpenResponsesNonStreamingResponse = (
	OpenAIResponsesNonStreamingResponse & { output: { ResponsesOutputItem }?, usage: OpenResponsesUsage? }
)

--[[
  Event emitted when a new output item is added to the response
]]
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

--[[
  Event emitted when an output item is complete
]]
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

--[[
  Event emitted when a text annotation is added to output
]]
export type OpenResponsesOutputTextAnnotationAddedEvent = {
	["type"]: "response.output_text.annotation.added",
	output_index: number,
	item_id: string,
	content_index: number,
	sequence_number: number,
	annotation_index: number,
	annotation: OpenAIResponsesAnnotation,
}

--[[
  Reasoning output item with signature and format extensions
]]
export type OpenResponsesReasoning = OutputItemReasoning & {
	signature: string?,
	format: ("unknown" | "openai-responses-v1" | "xai-responses-v1" | "anthropic-claude-v1")?,
}

--[[
  Configuration for reasoning mode in the response
]]
export type OpenResponsesReasoningConfig = OpenAIResponsesReasoningConfig & { max_tokens: number?, enabled: boolean? }

--[[
  Event emitted when reasoning text delta is streamed
]]
export type OpenResponsesReasoningDeltaEvent = OpenAIResponsesReasoningDeltaEvent

--[[
  Event emitted when reasoning text streaming is complete
]]
export type OpenResponsesReasoningDoneEvent = OpenAIResponsesReasoningDoneEvent

--[[
  Event emitted when a reasoning summary part is added
]]
export type OpenResponsesReasoningSummaryPartAddedEvent = OpenAIResponsesReasoningSummaryPartAddedEvent

--[[
  Event emitted when a reasoning summary part is complete
]]
export type OpenResponsesReasoningSummaryPartDoneEvent = {
	["type"]: "response.reasoning_summary_part.done",
	output_index: number,
	item_id: string,
	summary_index: number,
	part: ReasoningSummaryText,
	sequence_number: number,
}

--[[
  Event emitted when reasoning summary text delta is streamed
]]
export type OpenResponsesReasoningSummaryTextDeltaEvent = OpenAIResponsesReasoningSummaryTextDeltaEvent

--[[
  Event emitted when reasoning summary text streaming is complete
]]
export type OpenResponsesReasoningSummaryTextDoneEvent = OpenAIResponsesReasoningSummaryTextDoneEvent

--[[
  Event emitted when a refusal delta is streamed
]]
export type OpenResponsesRefusalDeltaEvent = {
	["type"]: "response.refusal.delta",
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[[
  Event emitted when refusal streaming is complete
]]
export type OpenResponsesRefusalDoneEvent = {
	["type"]: "response.refusal.done",
	output_index: number,
	item_id: string,
	content_index: number,
	refusal: string,
	sequence_number: number,
}

--[[
  Request schema for Responses endpoint
]]
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
	top_k: number?,
	prompt_cache_key: string?,
	previous_response_id: string?,
	prompt: OpenAIResponsesPrompt?,
	include: { OpenAIResponsesIncludable }?,
	background: boolean?,
	safety_identifier: string?,
	store: boolean?,
	service_tier: (OpenAIResponsesServiceTier & ("auto" | "default" | "flex" | "scale" | "priority"))?,
	truncation: (OpenAIResponsesTruncation & any)?,
	stream: boolean?,
	provider: {
		allow_fallbacks: boolean?,
		require_parameters: boolean?,
		data_collection: ("deny" | "allow")?,
		zdr: boolean?,
		order: { ProviderName | string }?,
		only: { ProviderName | string }?,
		ignore: { ProviderName | string }?,
		quantizations: { Quantization }?,
		sort: ("price" | "throughput" | "latency")?,
		max_price: {
			prompt: BigNumberUnion?,
			completion: BigNumberUnion?,
			image: BigNumberUnion?,
			audio: BigNumberUnion?,
			request: BigNumberUnion?,
		}?,
		experimental: {}?,
	}?,
	plugins: {
		(
			{ id: "moderation" }
			| { id: "web", max_results: number?, search_prompt: string?, engine: ("native" | "exa")? }
			| { id: "file-parser", max_files: number?, pdf: { engine: ("mistral-ocr" | "pdf-text" | "native")? }? }
		)
	}?,
	user: string?,
}

--[[
  Metadata key-value pairs for the request. Keys must be ≤64 characters and
  cannot contain brackets. Values must be ≤512 characters. Maximum 16 pairs
  allowed.
]]
export type OpenResponsesRequestMetadata = { [string]: string }?

--[[
  Text output configuration including format and verbosity
]]
export type OpenResponsesResponseText = ResponseTextConfig

--[[
  Union of all possible event types emitted during response streaming
]]
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

--[[
  Event emitted when a text delta is streamed
]]
export type OpenResponsesTextDeltaEvent = {
	["type"]: "response.output_text.delta",
	logprobs: { OpenResponsesLogProbs },
	output_index: number,
	item_id: string,
	content_index: number,
	delta: string,
	sequence_number: number,
}

--[[
  Event emitted when text streaming is complete
]]
export type OpenResponsesTextDoneEvent = {
	["type"]: "response.output_text.done",
	output_index: number,
	item_id: string,
	content_index: number,
	text: string,
	sequence_number: number,
	logprobs: { OpenResponsesLogProbs },
}

--[[
  Alternative token with its log probability
]]
export type OpenResponsesTopLogprobs = { token: string?, logprob: number? }

--[[
  Token usage information for the response
]]
export type OpenResponsesUsage = OpenAIResponsesUsage & {
	cost: number?,
	is_byok: boolean?,
	cost_details: {
		upstream_inference_cost: number?,
		upstream_inference_input_cost: number,
		upstream_inference_output_cost: number,
	}?,
}

--[[
  Web search tool configuration (2025-08-26 version)
]]
export type OpenResponsesWebSearch20250826Tool = {
	["type"]: "web_search_2025_08_26",
	filters: { allowed_domains: { string }? }?,
	search_context_size: ResponsesSearchContextSize?,
	user_location: ResponsesWebSearchUserLocation?,
}

--[[
  Web search preview tool configuration (2025-03-11 version)
]]
export type OpenResponsesWebSearchPreview20250311Tool = {
	["type"]: "web_search_preview_2025_03_11",
	search_context_size: ResponsesSearchContextSize?,
	user_location: WebSearchPreviewToolUserLocation?,
}

--[[
  Web search preview tool configuration
]]
export type OpenResponsesWebSearchPreviewTool = {
	["type"]: "web_search_preview",
	search_context_size: ResponsesSearchContextSize?,
	user_location: WebSearchPreviewToolUserLocation?,
}

--[[
  Web search tool configuration
]]
export type OpenResponsesWebSearchTool = {
	["type"]: "web_search",
	filters: { allowed_domains: { string }? }?,
	search_context_size: ResponsesSearchContextSize?,
	user_location: ResponsesWebSearchUserLocation?,
}

export type OutputItemFileSearchCall = {
	["type"]: "file_search_call",
	id: string,
	queries: { string },
	status: WebSearchStatus,
}

export type OutputItemFunctionCall = {
	["type"]: "function_call",
	id: string?,
	name: string,
	arguments: string,
	call_id: string,
	status: ("completed" | "incomplete" | "in_progress")?,
}

export type OutputItemImageGenerationCall = {
	["type"]: "image_generation_call",
	id: string,
	result: string?,
	status: ImageGenerationStatus,
}

export type OutputItemReasoning = {
	["type"]: "reasoning",
	id: string,
	content: { ReasoningTextContent }?,
	summary: { ReasoningSummaryText },
	encrypted_content: string?,
	status: ("completed" | "incomplete" | "in_progress")?,
}

export type OutputItemWebSearchCall = { ["type"]: "web_search_call", id: string, status: WebSearchStatus }

export type OutputMessage = {
	id: string,
	role: "assistant",
	["type"]: "message",
	status: ("completed" | "incomplete" | "in_progress")?,
	content: { ResponseOutputText | OpenAIResponsesRefusalContent },
}

export type OutputModality = "text" | "image" | "embeddings"

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
	| "web_search_options"
	| "verbosity"
)

--[[
  Payload Too Large - Request payload exceeds size limits
]]
export type PayloadTooLargeResponse = { error: PayloadTooLargeResponseErrorData, user_id: string? }

--[[
  Error data for PayloadTooLargeResponse
]]
export type PayloadTooLargeResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  Payment Required - Insufficient credits or quota to complete request
]]
export type PaymentRequiredResponse = { error: PaymentRequiredResponseErrorData, user_id: string? }

--[[
  Error data for PaymentRequiredResponse
]]
export type PaymentRequiredResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  Per-request token limits
]]
export type PerRequestLimits = { prompt_tokens: number, completion_tokens: number }?

export type ProviderName = (
	"AnyScale"
	| "Cent-ML"
	| "HuggingFace"
	| "Hyperbolic 2"
	| "Lepton"
	| "Lynn 2"
	| "Lynn"
	| "Mancer"
	| "Modal"
	| "OctoAI"
	| "Recursal"
	| "Reflection"
	| "Replicate"
	| "SambaNova 2"
	| "SF Compute"
	| "Together 2"
	| "01.AI"
	| "AI21"
	| "AionLabs"
	| "Alibaba"
	| "Amazon Bedrock"
	| "Anthropic"
	| "AtlasCloud"
	| "Atoma"
	| "Avian"
	| "Azure"
	| "BaseTen"
	| "Cerebras"
	| "Chutes"
	| "Cirrascale"
	| "Clarifai"
	| "Cloudflare"
	| "Cohere"
	| "CrofAI"
	| "Crusoe"
	| "DeepInfra"
	| "DeepSeek"
	| "Enfer"
	| "Featherless"
	| "Fireworks"
	| "Friendli"
	| "GMICloud"
	| "Google"
	| "Google AI Studio"
	| "Groq"
	| "Hyperbolic"
	| "Inception"
	| "InferenceNet"
	| "Infermatic"
	| "Inflection"
	| "InoCloud"
	| "Kluster"
	| "Lambda"
	| "Liquid"
	| "Mancer 2"
	| "Meta"
	| "Minimax"
	| "ModelRun"
	| "Mistral"
	| "Modular"
	| "Moonshot AI"
	| "Morph"
	| "NCompass"
	| "Nebius"
	| "NextBit"
	| "Nineteen"
	| "Novita"
	| "Nvidia"
	| "OpenAI"
	| "OpenInference"
	| "Parasail"
	| "Perplexity"
	| "Phala"
	| "Relace"
	| "SambaNova"
	| "SiliconFlow"
	| "Stealth"
	| "Switchpoint"
	| "Targon"
	| "Together"
	| "Ubicloud"
	| "Venice"
	| "WandB"
	| "xAI"
	| "Z.AI"
	| "FakeProvider"
)

--[[
  Provider Overloaded - Provider is temporarily overloaded
]]
export type ProviderOverloadedResponse = { error: ProviderOverloadedResponseErrorData, user_id: string? }

--[[
  Error data for ProviderOverloadedResponse
]]
export type ProviderOverloadedResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  Information about a specific model endpoint
]]
export type PublicEndpoint = {
	name: string,
	model_name: string,
	context_length: number,
	pricing: {
		prompt: BigNumberUnion,
		completion: BigNumberUnion,
		request: BigNumberUnion?,
		image: BigNumberUnion?,
		image_output: BigNumberUnion?,
		audio: BigNumberUnion?,
		input_audio_cache: BigNumberUnion?,
		web_search: BigNumberUnion?,
		internal_reasoning: BigNumberUnion?,
		input_cache_read: BigNumberUnion?,
		input_cache_write: BigNumberUnion?,
		discount: number?,
	},
	provider_name: ProviderName,
	tag: string,
	quantization: (Quantization & any)?,
	max_completion_tokens: number?,
	max_prompt_tokens: number?,
	supported_parameters: { Parameter },
	status: EndpointStatus?,
	uptime_last_30m: number?,
	supports_implicit_caching: boolean,
}

--[[
  Pricing information for the model
]]
export type PublicPricing = {
	prompt: BigNumberUnion,
	completion: BigNumberUnion,
	request: BigNumberUnion?,
	image: BigNumberUnion?,
	image_output: BigNumberUnion?,
	audio: BigNumberUnion?,
	input_audio_cache: BigNumberUnion?,
	web_search: BigNumberUnion?,
	internal_reasoning: BigNumberUnion?,
	input_cache_read: BigNumberUnion?,
	input_cache_write: BigNumberUnion?,
	discount: number?,
}

export type Quantization = "int4" | "int8" | "fp4" | "fp6" | "fp8" | "fp16" | "bf16" | "fp32" | "unknown"

export type ReasoningSummaryText = { ["type"]: "summary_text", text: string }

export type ReasoningSummaryVerbosity = "auto" | "concise" | "detailed"

export type ReasoningTextContent = { ["type"]: "reasoning_text", text: string }

--[[
  Request Timeout - Operation exceeded time limit
]]
export type RequestTimeoutResponse = { error: RequestTimeoutResponseErrorData, user_id: string? }

--[[
  Error data for RequestTimeoutResponse
]]
export type RequestTimeoutResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type ResponseFormatJSONSchema = { ["type"]: string, json_schema: JSONSchemaConfig }

--[[
  Text response format configuration
]]
export type ResponseFormatTextConfig = (
	ResponsesFormatText | ResponsesFormatJSONObject | ResponsesFormatTextJSONSchemaConfig
)

export type ResponseFormatTextGrammar = { ["type"]: string, grammar: string }

--[[
  Audio input content item
]]
export type ResponseInputAudio = { ["type"]: "input_audio", input_audio: { data: string, format: "mp3" | "wav" } }

--[[
  File input content item
]]
export type ResponseInputFile = {
	["type"]: "input_file",
	file_id: string?,
	file_data: string?,
	filename: string?,
	file_url: string?,
}

--[[
  Image input content item
]]
export type ResponseInputImage = { ["type"]: "input_image", detail: "auto" | "high" | "low", image_url: string? }

--[[
  Text input content item
]]
export type ResponseInputText = { ["type"]: "input_text", text: string }

export type ResponseOutputText = { ["type"]: "output_text", text: string, annotations: { OpenAIResponsesAnnotation }? }

--[[
  Text output configuration including format and verbosity
]]
export type ResponseTextConfig = { format: ResponseFormatTextConfig?, verbosity: ("high" | "low" | "medium")? }

--[[
  Error information returned from the API
]]
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

--[[
  JSON object response format
]]
export type ResponsesFormatJSONObject = { ["type"]: "json_object" }

--[[
  Plain text response format
]]
export type ResponsesFormatText = { ["type"]: "text" }

--[[
  JSON schema constrained response format
]]
export type ResponsesFormatTextJSONSchemaConfig = {
	["type"]: "json_schema",
	name: string,
	description: string?,
	strict: boolean?,
	schema: { [string]: any? },
}

export type ResponsesImageGenerationCall = OutputItemImageGenerationCall

--[[
  An output item from the response
]]
export type ResponsesOutputItem = (
	ResponsesOutputMessage
	| ResponsesOutputItemReasoning
	| ResponsesOutputItemFunctionCall
	| ResponsesWebSearchCallOutput
	| ResponsesOutputItemFileSearchCall
	| ResponsesImageGenerationCall
)

export type ResponsesOutputItemFileSearchCall = OutputItemFileSearchCall

export type ResponsesOutputItemFunctionCall = OutputItemFunctionCall

--[[
  An output item containing reasoning
]]
export type ResponsesOutputItemReasoning = {
	["type"]: "reasoning",
	id: string?,
	content: { ReasoningTextContent }?,
	summary: { ReasoningSummaryText },
	encrypted_content: string?,
	status: ("completed" | "incomplete" | "in_progress")?,
}

--[[
  An output message item
]]
export type ResponsesOutputMessage = OutputMessage

--[[
  Size of the search context for web search tools
]]
export type ResponsesSearchContextSize = "low" | "medium" | "high"

export type ResponsesWebSearchCallOutput = OutputItemWebSearchCall

--[[
  User location information for web search
]]
export type ResponsesWebSearchUserLocation = {
	["type"]: "approximate"?,
	city: string?,
	country: string?,
	region: string?,
	timezone: string?,
}?

--[[
  Service Unavailable - Service temporarily unavailable
]]
export type ServiceUnavailableResponse = { error: ServiceUnavailableResponseErrorData, user_id: string? }

--[[
  Error data for ServiceUnavailableResponse
]]
export type ServiceUnavailableResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type SystemMessage = { role: string, content: string | { ChatMessageContentItemText }, name: string? }

--[[
  Too Many Requests - Rate limit exceeded
]]
export type TooManyRequestsResponse = { error: TooManyRequestsResponseErrorData, user_id: string? }

--[[
  Error data for TooManyRequestsResponse
]]
export type TooManyRequestsResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type ToolCallStatus = "in_progress" | "completed" | "incomplete"

export type ToolChoiceOption = string | NamedToolChoice

export type ToolDefinitionJson = {
	["type"]: string,
	["function"]: { name: string, description: string?, parameters: { [string]: any }?, strict: (boolean | nil)? },
}

export type ToolResponseMessage = { role: string, content: string | { ChatMessageContentItem }, tool_call_id: string }

--[[
  Information about the top provider for this model
]]
export type TopProviderInfo = { context_length: number?, max_completion_tokens: number?, is_moderated: boolean }

export type URLCitation = { ["type"]: "url_citation", url: string, title: string, start_index: number, end_index: number }

--[[
  Unauthorized - Authentication required or invalid credentials
]]
export type UnauthorizedResponse = { error: UnauthorizedResponseErrorData, user_id: string? }

--[[
  Error data for UnauthorizedResponse
]]
export type UnauthorizedResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

--[[
  Unprocessable Entity - Semantic validation failure
]]
export type UnprocessableEntityResponse = { error: UnprocessableEntityResponseErrorData, user_id: string? }

--[[
  Error data for UnprocessableEntityResponse
]]
export type UnprocessableEntityResponseErrorData = { code: number, message: string, metadata: { [string]: any? }? }

export type UserMessage = { role: string, content: string | { ChatMessageContentItem }, name: string? }

export type WebSearchPreviewToolUserLocation = {
	["type"]: "approximate",
	city: string?,
	country: string?,
	region: string?,
	timezone: string?,
}?

export type WebSearchStatus = "completed" | "searching" | "in_progress" | "failed"

export type __schema0 = ChatCompletionFinishReason | nil

--[[
  200 Response type for createResponses
]]
export type CreateResponses200Response = OpenResponsesNonStreamingResponse

--[[
  400 Response type for createResponses
]]
export type CreateResponses400Response = BadRequestResponse

--[[
  401 Response type for createResponses
]]
export type CreateResponses401Response = UnauthorizedResponse

--[[
  402 Response type for createResponses
]]
export type CreateResponses402Response = PaymentRequiredResponse

--[[
  404 Response type for createResponses
]]
export type CreateResponses404Response = NotFoundResponse

--[[
  408 Response type for createResponses
]]
export type CreateResponses408Response = RequestTimeoutResponse

--[[
  413 Response type for createResponses
]]
export type CreateResponses413Response = PayloadTooLargeResponse

--[[
  422 Response type for createResponses
]]
export type CreateResponses422Response = UnprocessableEntityResponse

--[[
  429 Response type for createResponses
]]
export type CreateResponses429Response = TooManyRequestsResponse

--[[
  500 Response type for createResponses
]]
export type CreateResponses500Response = InternalServerResponse

--[[
  502 Response type for createResponses
]]
export type CreateResponses502Response = BadGatewayResponse

--[[
  503 Response type for createResponses
]]
export type CreateResponses503Response = ServiceUnavailableResponse

--[[
  524 Response type for createResponses
]]
export type CreateResponses524Response = EdgeNetworkTimeoutResponse

--[[
  529 Response type for createResponses
]]
export type CreateResponses529Response = ProviderOverloadedResponse

--[[
  200 Response type for getUserActivity
]]
export type GetUserActivity200Response = { data: { ActivityItem } }

--[[
  400 Response type for getUserActivity
]]
export type GetUserActivity400Response = BadRequestResponse

--[[
  401 Response type for getUserActivity
]]
export type GetUserActivity401Response = UnauthorizedResponse

--[[
  403 Response type for getUserActivity
]]
export type GetUserActivity403Response = ForbiddenResponse

--[[
  500 Response type for getUserActivity
]]
export type GetUserActivity500Response = InternalServerResponse

--[[
  200 Response type for getCredits
]]
export type GetCredits200Response = {}

--[[
  401 Response type for getCredits
]]
export type GetCredits401Response = UnauthorizedResponse

--[[
  403 Response type for getCredits
]]
export type GetCredits403Response = ForbiddenResponse

--[[
  500 Response type for getCredits
]]
export type GetCredits500Response = InternalServerResponse

--[[
  200 Response type for createCoinbaseCharge
]]
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

--[[
  400 Response type for createCoinbaseCharge
]]
export type CreateCoinbaseCharge400Response = BadRequestResponse

--[[
  401 Response type for createCoinbaseCharge
]]
export type CreateCoinbaseCharge401Response = UnauthorizedResponse

--[[
  429 Response type for createCoinbaseCharge
]]
export type CreateCoinbaseCharge429Response = TooManyRequestsResponse

--[[
  500 Response type for createCoinbaseCharge
]]
export type CreateCoinbaseCharge500Response = InternalServerResponse

--[[
  200 Response type for createEmbeddings
]]
export type CreateEmbeddings200Response = {
	id: string?,
	object: "list",
	data: { { object: "embedding", embedding: { number } | string, index: number? } },
	model: string,
	usage: { prompt_tokens: number, total_tokens: number, cost: number? }?,
}

--[[
  400 Response type for createEmbeddings
]]
export type CreateEmbeddings400Response = BadRequestResponse

--[[
  401 Response type for createEmbeddings
]]
export type CreateEmbeddings401Response = UnauthorizedResponse

--[[
  402 Response type for createEmbeddings
]]
export type CreateEmbeddings402Response = PaymentRequiredResponse

--[[
  404 Response type for createEmbeddings
]]
export type CreateEmbeddings404Response = NotFoundResponse

--[[
  429 Response type for createEmbeddings
]]
export type CreateEmbeddings429Response = TooManyRequestsResponse

--[[
  500 Response type for createEmbeddings
]]
export type CreateEmbeddings500Response = InternalServerResponse

--[[
  502 Response type for createEmbeddings
]]
export type CreateEmbeddings502Response = BadGatewayResponse

--[[
  503 Response type for createEmbeddings
]]
export type CreateEmbeddings503Response = ServiceUnavailableResponse

--[[
  524 Response type for createEmbeddings
]]
export type CreateEmbeddings524Response = EdgeNetworkTimeoutResponse

--[[
  529 Response type for createEmbeddings
]]
export type CreateEmbeddings529Response = ProviderOverloadedResponse

--[[
  200 Response type for getGeneration
]]
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
	},
}

--[[
  401 Response type for getGeneration
]]
export type GetGeneration401Response = UnauthorizedResponse

--[[
  402 Response type for getGeneration
]]
export type GetGeneration402Response = PaymentRequiredResponse

--[[
  404 Response type for getGeneration
]]
export type GetGeneration404Response = NotFoundResponse

--[[
  429 Response type for getGeneration
]]
export type GetGeneration429Response = TooManyRequestsResponse

--[[
  500 Response type for getGeneration
]]
export type GetGeneration500Response = InternalServerResponse

--[[
  502 Response type for getGeneration
]]
export type GetGeneration502Response = BadGatewayResponse

--[[
  524 Response type for getGeneration
]]
export type GetGeneration524Response = EdgeNetworkTimeoutResponse

--[[
  529 Response type for getGeneration
]]
export type GetGeneration529Response = ProviderOverloadedResponse

--[[
  200 Response type for listModelsCount
]]
export type ListModelsCount200Response = ModelsCountResponse

--[[
  500 Response type for listModelsCount
]]
export type ListModelsCount500Response = InternalServerResponse

--[[
  200 Response type for getModels
]]
export type GetModels200Response = ModelsListResponse

--[[
  400 Response type for getModels
]]
export type GetModels400Response = BadRequestResponse

--[[
  500 Response type for getModels
]]
export type GetModels500Response = InternalServerResponse

--[[
  200 Response type for listModelsEmbeddings
]]
export type ListModelsEmbeddings200Response = ModelsListResponse

--[[
  400 Response type for listModelsEmbeddings
]]
export type ListModelsEmbeddings400Response = BadRequestResponse

--[[
  500 Response type for listModelsEmbeddings
]]
export type ListModelsEmbeddings500Response = InternalServerResponse

--[[
  200 Response type for listModelsUser
]]
export type ListModelsUser200Response = ModelsListResponse

--[[
  401 Response type for listModelsUser
]]
export type ListModelsUser401Response = UnauthorizedResponse

--[[
  500 Response type for listModelsUser
]]
export type ListModelsUser500Response = InternalServerResponse

--[[
  200 Response type for listEndpoints
]]
export type ListEndpoints200Response = { data: ListEndpointsResponse }

--[[
  404 Response type for listEndpoints
]]
export type ListEndpoints404Response = NotFoundResponse

--[[
  500 Response type for listEndpoints
]]
export type ListEndpoints500Response = InternalServerResponse

--[[
  200 Response type for listEndpointsZdr
]]
export type ListEndpointsZdr200Response = { data: { PublicEndpoint } }

--[[
  500 Response type for listEndpointsZdr
]]
export type ListEndpointsZdr500Response = InternalServerResponse

--[[
  200 Response type for getParameters
]]
export type GetParameters200Response = {
	data: {
		model: string,
		supported_parameters: {
			(
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
				| "web_search_options"
				| "verbosity"
			)
		},
	},
}

--[[
  401 Response type for getParameters
]]
export type GetParameters401Response = UnauthorizedResponse

--[[
  404 Response type for getParameters
]]
export type GetParameters404Response = NotFoundResponse

--[[
  500 Response type for getParameters
]]
export type GetParameters500Response = InternalServerResponse

--[[
  200 Response type for listProviders
]]
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

--[[
  500 Response type for listProviders
]]
export type ListProviders500Response = InternalServerResponse

--[[
  200 Response type for list
]]
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
		}
	},
}

--[[
  401 Response type for list
]]
export type List401Response = UnauthorizedResponse

--[[
  429 Response type for list
]]
export type List429Response = TooManyRequestsResponse

--[[
  500 Response type for list
]]
export type List500Response = InternalServerResponse

--[[
  201 Response type for createKeys
]]
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
	},
	key: string,
}

--[[
  400 Response type for createKeys
]]
export type CreateKeys400Response = BadRequestResponse

--[[
  401 Response type for createKeys
]]
export type CreateKeys401Response = UnauthorizedResponse

--[[
  429 Response type for createKeys
]]
export type CreateKeys429Response = TooManyRequestsResponse

--[[
  500 Response type for createKeys
]]
export type CreateKeys500Response = InternalServerResponse

--[[
  200 Response type for getKey
]]
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
	},
}

--[[
  401 Response type for getKey
]]
export type GetKey401Response = UnauthorizedResponse

--[[
  404 Response type for getKey
]]
export type GetKey404Response = NotFoundResponse

--[[
  429 Response type for getKey
]]
export type GetKey429Response = TooManyRequestsResponse

--[[
  500 Response type for getKey
]]
export type GetKey500Response = InternalServerResponse

--[[
  200 Response type for deleteKeys
]]
export type DeleteKeys200Response = { deleted: boolean }

--[[
  401 Response type for deleteKeys
]]
export type DeleteKeys401Response = UnauthorizedResponse

--[[
  404 Response type for deleteKeys
]]
export type DeleteKeys404Response = NotFoundResponse

--[[
  429 Response type for deleteKeys
]]
export type DeleteKeys429Response = TooManyRequestsResponse

--[[
  500 Response type for deleteKeys
]]
export type DeleteKeys500Response = InternalServerResponse

--[[
  200 Response type for updateKeys
]]
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
	},
}

--[[
  400 Response type for updateKeys
]]
export type UpdateKeys400Response = BadRequestResponse

--[[
  401 Response type for updateKeys
]]
export type UpdateKeys401Response = UnauthorizedResponse

--[[
  404 Response type for updateKeys
]]
export type UpdateKeys404Response = NotFoundResponse

--[[
  429 Response type for updateKeys
]]
export type UpdateKeys429Response = TooManyRequestsResponse

--[[
  500 Response type for updateKeys
]]
export type UpdateKeys500Response = InternalServerResponse

--[[
  200 Response type for getCurrentKey
]]
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
		is_provisioning_key: boolean,
		limit_remaining: number?,
		limit_reset: string?,
		include_byok_in_limit: boolean,
		rate_limit: { requests: number, interval: string, note: string },
	},
}

--[[
  401 Response type for getCurrentKey
]]
export type GetCurrentKey401Response = UnauthorizedResponse

--[[
  500 Response type for getCurrentKey
]]
export type GetCurrentKey500Response = InternalServerResponse

--[[
  200 Response type for exchangeAuthCodeForAPIKey
]]
export type ExchangeAuthCodeForAPIKey200Response = { key: string, user_id: string? }

--[[
  400 Response type for exchangeAuthCodeForAPIKey
]]
export type ExchangeAuthCodeForAPIKey400Response = BadRequestResponse

--[[
  403 Response type for exchangeAuthCodeForAPIKey
]]
export type ExchangeAuthCodeForAPIKey403Response = ForbiddenResponse

--[[
  500 Response type for exchangeAuthCodeForAPIKey
]]
export type ExchangeAuthCodeForAPIKey500Response = InternalServerResponse

--[[
  200 Response type for createAuthKeysCode
]]
export type CreateAuthKeysCode200Response = { data: { id: string, app_id: number, created_at: string } }

--[[
  400 Response type for createAuthKeysCode
]]
export type CreateAuthKeysCode400Response = BadRequestResponse

--[[
  401 Response type for createAuthKeysCode
]]
export type CreateAuthKeysCode401Response = UnauthorizedResponse

--[[
  500 Response type for createAuthKeysCode
]]
export type CreateAuthKeysCode500Response = InternalServerResponse

--[[
  200 Response type for sendChatCompletionRequest
]]
export type SendChatCompletionRequest200Response = ChatResponse

--[[
  400 Response type for sendChatCompletionRequest
]]
export type SendChatCompletionRequest400Response = ChatError

--[[
  401 Response type for sendChatCompletionRequest
]]
export type SendChatCompletionRequest401Response = ChatError

--[[
  429 Response type for sendChatCompletionRequest
]]
export type SendChatCompletionRequest429Response = ChatError

--[[
  500 Response type for sendChatCompletionRequest
]]
export type SendChatCompletionRequest500Response = ChatError

--[[
  200 Response type for createCompletions
]]
export type CreateCompletions200Response = CompletionResponse

--[[
  400 Response type for createCompletions
]]
export type CreateCompletions400Response = ChatError

--[[
  401 Response type for createCompletions
]]
export type CreateCompletions401Response = ChatError

--[[
  429 Response type for createCompletions
]]
export type CreateCompletions429Response = ChatError

--[[
  500 Response type for createCompletions
]]
export type CreateCompletions500Response = ChatError
return {}

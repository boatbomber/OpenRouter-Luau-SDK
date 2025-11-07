--!strict
-- This file is auto-generated from OpenRouter API
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: 2025-11-07T03:38:10.972776Z (generator v1.0.0)
-- Documentation: https://openrouter.ai/docs - OpenRouter Documentation

--[[
  OpenRouter API - Generated API Methods
]]

local HttpService = game:GetService("HttpService")
local Types = require(script.types)

--- @class OpenRouter
--- The OpenRouter class is an auto-generated class for interacting with the OpenRouter APIs.
local OpenRouter = {}
OpenRouter.__index = OpenRouter

type OpenRouterProto = {
	apiKey: string,
}

export type OpenRouter = typeof(setmetatable({} :: OpenRouterProto, OpenRouter))

function OpenRouter.new(apiKey: string): OpenRouter
	local self = setmetatable({}, OpenRouter)
	self.apiKey = apiKey
	return self
end

function OpenRouter._buildQueryString(_self: OpenRouter, queryParams: { [string]: any }): string
	local queryParts = {}
	for key, value in queryParams do
		if value then
			table.insert(queryParts, key .. "=" .. tostring(value))
		end
	end

	if #queryParts > 0 then
		return "?" .. table.concat(queryParts, "&")
	end
	return ""
end

function OpenRouter._request<T, E>(self: OpenRouter, method: Types.HttpMethod, path: string, body: any?): Types.Result<T, E>
	local ok, result = pcall(function()
		return HttpService:RequestAsync({
			Url = "https://openrouter.ai/api/v1" .. path,
			Method = method,
			Headers = {
				["Authorization"] = "Bearer " .. self.apiKey,
				["Content-Type"] = "application/json",
				-- Used for usage rankings on openrouter.ai
				["HTTP-Referer"] = `https://www.roblox.com/games/{game.GameId}/{game.Name}`,
				["X-Title"] = game.Name,
			},
			Body = if body then HttpService:JSONEncode(body) else nil,
		})
	end)

	if not ok then
		return { type = "crash", error = tostring(result) }
	end

	if result.Success then
		return { type = "ok", value = if result.Body then HttpService:JSONDecode(result.Body) else nil }
	end

	return { type = "err", error = if result.Body then HttpService:JSONDecode(result.Body) else nil }
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  beta.responses: beta.responses endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Creates a streaming or non-streaming response using OpenResponses API format

    Endpoint: POST /responses

    @method createResponses
    @within OpenRouter
    @tag beta.responses
    
    @param params OpenResponsesRequest -- Request body parameters
    @return Result<CreateResponses200Response, CreateResponses400Response | CreateResponses401Response | CreateResponses402Response | CreateResponses404Response | CreateResponses408Response | CreateResponses413Response | CreateResponses422Response | CreateResponses429Response | CreateResponses500Response | CreateResponses502Response | CreateResponses503Response | CreateResponses524Response | CreateResponses529Response>
]=]
function OpenRouter.createResponses(
	self: OpenRouter,
	params: Types.OpenResponsesRequest
): Types.Result<
	Types.CreateResponses200Response,
	Types.CreateResponses400Response
	| Types.CreateResponses401Response
	| Types.CreateResponses402Response
	| Types.CreateResponses404Response
	| Types.CreateResponses408Response
	| Types.CreateResponses413Response
	| Types.CreateResponses422Response
	| Types.CreateResponses429Response
	| Types.CreateResponses500Response
	| Types.CreateResponses502Response
	| Types.CreateResponses503Response
	| Types.CreateResponses524Response
	| Types.CreateResponses529Response
>
	return self:_request("POST", "/responses", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Analytics: Analytics and usage endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Returns user activity data grouped by endpoint for the last 30 (completed) UTC days

    Endpoint: GET /activity

    @method getUserActivity
    @within OpenRouter
    @tag Analytics
    
    @param date string? -- Filter by a single UTC date in the last 30 days (YYYY-MM-DD format).
    @return Result<GetUserActivity200Response, GetUserActivity400Response | GetUserActivity401Response | GetUserActivity403Response | GetUserActivity500Response>
]=]
function OpenRouter.getUserActivity(
	self: OpenRouter,
	date: string?
): Types.Result<
	Types.GetUserActivity200Response,
	Types.GetUserActivity400Response
	| Types.GetUserActivity401Response
	| Types.GetUserActivity403Response
	| Types.GetUserActivity500Response
>
	local queryString = self:_buildQueryString({
		["date"] = date,
	})
	return self:_request("GET", `/activity{queryString}`, nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Credits: Credit management endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Get total credits purchased and used for the authenticated user

    Endpoint: GET /credits

    @method getCredits
    @within OpenRouter
    @tag Credits
    
    @return Result<GetCredits200Response, GetCredits401Response | GetCredits403Response | GetCredits500Response>
]=]
function OpenRouter.getCredits(self: OpenRouter): Types.Result<
	Types.GetCredits200Response,
	Types.GetCredits401Response | Types.GetCredits403Response | Types.GetCredits500Response
>
	return self:_request("GET", "/credits", nil)
end

--[=[
    Create a Coinbase charge for crypto payment

    Endpoint: POST /credits/coinbase

    @method createCoinbaseCharge
    @within OpenRouter
    @tag Credits
    
    @param params CreateChargeRequest -- Request body parameters
    @return Result<CreateCoinbaseCharge200Response, CreateCoinbaseCharge400Response | CreateCoinbaseCharge401Response | CreateCoinbaseCharge429Response | CreateCoinbaseCharge500Response>
]=]
function OpenRouter.createCoinbaseCharge(
	self: OpenRouter,
	params: Types.CreateChargeRequest
): Types.Result<
	Types.CreateCoinbaseCharge200Response,
	Types.CreateCoinbaseCharge400Response
	| Types.CreateCoinbaseCharge401Response
	| Types.CreateCoinbaseCharge429Response
	| Types.CreateCoinbaseCharge500Response
>
	return self:_request("POST", "/credits/coinbase", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Embeddings: Text embedding endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Submits an embedding request to the embeddings router

    Endpoint: POST /embeddings

    @method createEmbeddings
    @within OpenRouter
    @tag Embeddings
    
    @param params { input: (string | {string} | {number} | {{number}}), model: string, provider: { allow_fallbacks: boolean?, require_parameters: boolean?, data_collection: ("deny" | "allow")?, zdr: boolean?, order: {(ProviderName | string)}?, only: {(ProviderName | string)}?, ignore: {(ProviderName | string)}?, quantizations: {Quantization}?, sort: ("price" | "throughput" | "latency")?, max_price: { prompt: BigNumberUnion?, completion: BigNumberUnion?, image: BigNumberUnion?, audio: BigNumberUnion?, request: BigNumberUnion? }?, experimental: {}? }?, encoding_format: ("float" | "base64")?, user: string? } -- Request body parameters
    @return Result<CreateEmbeddings200Response, CreateEmbeddings400Response | CreateEmbeddings401Response | CreateEmbeddings402Response | CreateEmbeddings404Response | CreateEmbeddings429Response | CreateEmbeddings500Response | CreateEmbeddings502Response | CreateEmbeddings503Response | CreateEmbeddings524Response | CreateEmbeddings529Response>
]=]
function OpenRouter.createEmbeddings(
	self: OpenRouter,
	params: {
		input: string | { string } | { number } | { { number } },
		model: string,
		provider: {
			allow_fallbacks: boolean?,
			require_parameters: boolean?,
			data_collection: ("deny" | "allow")?,
			zdr: boolean?,
			order: { Types.ProviderName | string }?,
			only: { Types.ProviderName | string }?,
			ignore: { Types.ProviderName | string }?,
			quantizations: { Types.Quantization }?,
			sort: ("price" | "throughput" | "latency")?,
			max_price: {
				prompt: Types.BigNumberUnion?,
				completion: Types.BigNumberUnion?,
				image: Types.BigNumberUnion?,
				audio: Types.BigNumberUnion?,
				request: Types.BigNumberUnion?,
			}?,
			experimental: {}?,
		}?,
		encoding_format: ("float" | "base64")?,
		user: string?,
	}
): Types.Result<
	Types.CreateEmbeddings200Response,
	Types.CreateEmbeddings400Response
	| Types.CreateEmbeddings401Response
	| Types.CreateEmbeddings402Response
	| Types.CreateEmbeddings404Response
	| Types.CreateEmbeddings429Response
	| Types.CreateEmbeddings500Response
	| Types.CreateEmbeddings502Response
	| Types.CreateEmbeddings503Response
	| Types.CreateEmbeddings524Response
	| Types.CreateEmbeddings529Response
>
	return self:_request("POST", "/embeddings", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Generations: Generation history endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Get request & usage metadata for a generation

    Endpoint: GET /generation

    @method getGeneration
    @within OpenRouter
    @tag Generations
    
    @param id string -- No description provided
    @return Result<GetGeneration200Response, GetGeneration401Response | GetGeneration402Response | GetGeneration404Response | GetGeneration429Response | GetGeneration500Response | GetGeneration502Response | GetGeneration524Response | GetGeneration529Response>
]=]
function OpenRouter.getGeneration(
	self: OpenRouter,
	id: string
): Types.Result<
	Types.GetGeneration200Response,
	Types.GetGeneration401Response
	| Types.GetGeneration402Response
	| Types.GetGeneration404Response
	| Types.GetGeneration429Response
	| Types.GetGeneration500Response
	| Types.GetGeneration502Response
	| Types.GetGeneration524Response
	| Types.GetGeneration529Response
>
	local queryString = self:_buildQueryString({
		["id"] = id,
	})
	return self:_request("GET", `/generation{queryString}`, nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Models: Model information endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Get total count of available models

    Endpoint: GET /models/count

    @method listModelsCount
    @within OpenRouter
    @tag Models
    
    @return Result<ListModelsCount200Response, ListModelsCount500Response>
]=]
function OpenRouter.listModelsCount(
	self: OpenRouter
): Types.Result<Types.ListModelsCount200Response, Types.ListModelsCount500Response>
	return self:_request("GET", "/models/count", nil)
end

--[=[
    List all models and their properties

    Endpoint: GET /models

    @method getModels
    @within OpenRouter
    @tag Models
    
    @param category string? -- No description provided
    @param supported_parameters string? -- No description provided
    @param use_rss string? -- No description provided
    @param use_rss_chat_links string? -- No description provided
    @return Result<GetModels200Response, GetModels400Response | GetModels500Response>
]=]
function OpenRouter.getModels(
	self: OpenRouter,
	category: string?,
	supported_parameters: string?,
	use_rss: string?,
	use_rss_chat_links: string?
): Types.Result<
	Types.GetModels200Response,
	Types.GetModels400Response | Types.GetModels500Response
>
	local queryString = self:_buildQueryString({
		["category"] = category,
		["supported_parameters"] = supported_parameters,
		["use_rss"] = use_rss,
		["use_rss_chat_links"] = use_rss_chat_links,
	})
	return self:_request("GET", `/models{queryString}`, nil)
end

--[=[
    Returns a list of all available embeddings models and their properties

    Endpoint: GET /models/embeddings

    @method listModelsEmbeddings
    @within OpenRouter
    @tag Models
    
    @return Result<ListModelsEmbeddings200Response, ListModelsEmbeddings400Response | ListModelsEmbeddings500Response>
]=]
function OpenRouter.listModelsEmbeddings(self: OpenRouter): Types.Result<
	Types.ListModelsEmbeddings200Response,
	Types.ListModelsEmbeddings400Response | Types.ListModelsEmbeddings500Response
>
	return self:_request("GET", "/models/embeddings", nil)
end

--[=[
    List models filtered by user provider preferences

    Endpoint: GET /models/user

    @method listModelsUser
    @within OpenRouter
    @tag Models
    
    @return Result<ListModelsUser200Response, ListModelsUser401Response | ListModelsUser500Response>
]=]
function OpenRouter.listModelsUser(self: OpenRouter): Types.Result<
	Types.ListModelsUser200Response,
	Types.ListModelsUser401Response | Types.ListModelsUser500Response
>
	return self:_request("GET", "/models/user", nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Endpoints: Endpoint information
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    List all endpoints for a model

    Endpoint: GET /models/{author}/{slug}/endpoints

    @method listEndpoints
    @within OpenRouter
    @tag Endpoints
    
    @param author string -- No description provided
    @param slug string -- No description provided
    @return Result<ListEndpoints200Response, ListEndpoints404Response | ListEndpoints500Response>
]=]
function OpenRouter.listEndpoints(
	self: OpenRouter,
	author: string,
	slug: string
): Types.Result<
	Types.ListEndpoints200Response,
	Types.ListEndpoints404Response | Types.ListEndpoints500Response
>
	return self:_request("GET", `/models/{author}/{slug}/endpoints`, nil)
end

--[=[
    Preview the impact of ZDR on the available endpoints

    Endpoint: GET /endpoints/zdr

    @method listEndpointsZdr
    @within OpenRouter
    @tag Endpoints
    
    @return Result<ListEndpointsZdr200Response, ListEndpointsZdr500Response>
]=]
function OpenRouter.listEndpointsZdr(
	self: OpenRouter
): Types.Result<Types.ListEndpointsZdr200Response, Types.ListEndpointsZdr500Response>
	return self:_request("GET", "/endpoints/zdr", nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Parameters: Parameters endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Get a model's supported parameters and data about which are most popular

    Endpoint: GET /parameters/{author}/{slug}

    @method getParameters
    @within OpenRouter
    @tag Parameters
    
    @param author string -- No description provided
    @param slug string -- No description provided
    @param provider ("AI21" | "AionLabs" | "Alibaba" | "Amazon Bedrock" | "Anthropic" | "AtlasCloud" | "Atoma" | "Avian" | "Azure" | "BaseTen" | "Cerebras" | "Chutes" | "Cirrascale" | "Clarifai" | "Cloudflare" | "Cohere" | "CrofAI" | "Crusoe" | "DeepInfra" | "DeepSeek" | "Enfer" | "Featherless" | "Fireworks" | "Friendli" | "GMICloud" | "Google" | "Google AI Studio" | "Groq" | "Hyperbolic" | "Inception" | "InferenceNet" | "Infermatic" | "Inflection" | "Kluster" | "Lambda" | "Liquid" | "Mancer 2" | "Meta" | "Minimax" | "ModelRun" | "Mistral" | "Modular" | "Moonshot AI" | "Morph" | "NCompass" | "Nebius" | "NextBit" | "Nineteen" | "Novita" | "Nvidia" | "OpenAI" | "OpenInference" | "Parasail" | "Perplexity" | "Phala" | "Relace" | "SambaNova" | "SiliconFlow" | "Stealth" | "Switchpoint" | "Targon" | "Together" | "Ubicloud" | "Venice" | "WandB" | "xAI" | "Z.AI" | "FakeProvider")? -- No description provided
    @return Result<GetParameters200Response, GetParameters401Response | GetParameters404Response | GetParameters500Response>
]=]
function OpenRouter.getParameters(
	self: OpenRouter,
	author: string,
	slug: string,
	provider: (
		"AI21"
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
	)?
): Types.Result<
	Types.GetParameters200Response,
	Types.GetParameters401Response | Types.GetParameters404Response | Types.GetParameters500Response
>
	local queryString = self:_buildQueryString({
		["provider"] = provider,
	})
	return self:_request("GET", `/parameters/{author}/{slug}{queryString}`, nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Providers: Provider information endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    List all providers

    Endpoint: GET /providers

    @method listProviders
    @within OpenRouter
    @tag Providers
    
    @return Result<ListProviders200Response, ListProviders500Response>
]=]
function OpenRouter.listProviders(
	self: OpenRouter
): Types.Result<Types.ListProviders200Response, Types.ListProviders500Response>
	return self:_request("GET", "/providers", nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  API Keys: API key management endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    List API keys

    Endpoint: GET /keys

    @method list
    @within OpenRouter
    @tag API Keys
    
    @param include_disabled string? -- Whether to include disabled API keys in the response
    @param offset string? -- Number of API keys to skip for pagination
    @return Result<List200Response, List401Response | List429Response | List500Response>
]=]
function OpenRouter.list(
	self: OpenRouter,
	include_disabled: string?,
	offset: string?
): Types.Result<
	Types.List200Response,
	Types.List401Response | Types.List429Response | Types.List500Response
>
	local queryString = self:_buildQueryString({
		["include_disabled"] = include_disabled,
		["offset"] = offset,
	})
	return self:_request("GET", `/keys{queryString}`, nil)
end

--[=[
    Create a new API key

    Endpoint: POST /keys

    @method createKeys
    @within OpenRouter
    @tag API Keys
    
    @param params { name: string, limit: number?, limit_reset: ("daily" | "weekly" | "monthly")?, include_byok_in_limit: boolean? } -- Request body parameters
    @return Result<CreateKeys201Response, CreateKeys400Response | CreateKeys401Response | CreateKeys429Response | CreateKeys500Response>
]=]
function OpenRouter.createKeys(
	self: OpenRouter,
	params: {
		name: string,
		limit: number?,
		limit_reset: ("daily" | "weekly" | "monthly")?,
		include_byok_in_limit: boolean?,
	}
): Types.Result<
	Types.CreateKeys201Response,
	Types.CreateKeys400Response
	| Types.CreateKeys401Response
	| Types.CreateKeys429Response
	| Types.CreateKeys500Response
>
	return self:_request("POST", "/keys", params)
end

--[=[
    Get a single API key

    Endpoint: GET /keys/{hash}

    @method getKey
    @within OpenRouter
    @tag API Keys
    
    @param hash string -- The hash identifier of the API key to retrieve
    @return Result<GetKey200Response, GetKey401Response | GetKey404Response | GetKey429Response | GetKey500Response>
]=]
function OpenRouter.getKey(
	self: OpenRouter,
	hash: string
): Types.Result<
	Types.GetKey200Response,
	Types.GetKey401Response | Types.GetKey404Response | Types.GetKey429Response | Types.GetKey500Response
>
	return self:_request("GET", `/keys/{hash}`, nil)
end

--[=[
    Delete an API key

    Endpoint: DELETE /keys/{hash}

    @method deleteKeys
    @within OpenRouter
    @tag API Keys
    
    @param hash string -- The hash identifier of the API key to delete
    @return Result<DeleteKeys200Response, DeleteKeys401Response | DeleteKeys404Response | DeleteKeys429Response | DeleteKeys500Response>
]=]
function OpenRouter.deleteKeys(
	self: OpenRouter,
	hash: string
): Types.Result<
	Types.DeleteKeys200Response,
	Types.DeleteKeys401Response
	| Types.DeleteKeys404Response
	| Types.DeleteKeys429Response
	| Types.DeleteKeys500Response
>
	return self:_request("DELETE", `/keys/{hash}`, nil)
end

--[=[
    Update an API key

    Endpoint: PATCH /keys/{hash}

    @method updateKeys
    @within OpenRouter
    @tag API Keys
    
    @param hash string -- The hash identifier of the API key to update
    @param params { name: string?, disabled: boolean?, limit: number?, limit_reset: ("daily" | "weekly" | "monthly")?, include_byok_in_limit: boolean? } -- Request body parameters
    @return Result<UpdateKeys200Response, UpdateKeys400Response | UpdateKeys401Response | UpdateKeys404Response | UpdateKeys429Response | UpdateKeys500Response>
]=]
function OpenRouter.updateKeys(
	self: OpenRouter,
	hash: string,
	params: {
		name: string?,
		disabled: boolean?,
		limit: number?,
		limit_reset: ("daily" | "weekly" | "monthly")?,
		include_byok_in_limit: boolean?,
	}
): Types.Result<
	Types.UpdateKeys200Response,
	Types.UpdateKeys400Response
	| Types.UpdateKeys401Response
	| Types.UpdateKeys404Response
	| Types.UpdateKeys429Response
	| Types.UpdateKeys500Response
>
	return self:_request("PATCH", `/keys/{hash}`, params)
end

--[=[
    Get information on the API key associated with the current authentication session

    Endpoint: GET /key

    @method getCurrentKey
    @within OpenRouter
    @tag API Keys
    
    @return Result<GetCurrentKey200Response, GetCurrentKey401Response | GetCurrentKey500Response>
]=]
function OpenRouter.getCurrentKey(self: OpenRouter): Types.Result<
	Types.GetCurrentKey200Response,
	Types.GetCurrentKey401Response | Types.GetCurrentKey500Response
>
	return self:_request("GET", "/key", nil)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  OAuth: OAuth authentication endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Exchange an authorization code from the PKCE flow for a user-controlled API key

    Endpoint: POST /auth/keys

    @method exchangeAuthCodeForAPIKey
    @within OpenRouter
    @tag OAuth
    
    @param params { code: string, code_verifier: string?, code_challenge_method: ("S256" | "plain")? } -- Request body parameters
    @return Result<ExchangeAuthCodeForAPIKey200Response, ExchangeAuthCodeForAPIKey400Response | ExchangeAuthCodeForAPIKey403Response | ExchangeAuthCodeForAPIKey500Response>
]=]
function OpenRouter.exchangeAuthCodeForAPIKey(
	self: OpenRouter,
	params: {
		code: string,
		code_verifier: string?,
		code_challenge_method: ("S256" | "plain")?,
	}
): Types.Result<
	Types.ExchangeAuthCodeForAPIKey200Response,
	Types.ExchangeAuthCodeForAPIKey400Response
	| Types.ExchangeAuthCodeForAPIKey403Response
	| Types.ExchangeAuthCodeForAPIKey500Response
>
	return self:_request("POST", "/auth/keys", params)
end

--[=[
    Create an authorization code for the PKCE flow to generate a user-controlled API key

    Endpoint: POST /auth/keys/code

    @method createAuthKeysCode
    @within OpenRouter
    @tag OAuth
    
    @param params { callback_url: string, code_challenge: string?, code_challenge_method: ("S256" | "plain")?, limit: number? } -- Request body parameters
    @return Result<CreateAuthKeysCode200Response, CreateAuthKeysCode400Response | CreateAuthKeysCode401Response | CreateAuthKeysCode500Response>
]=]
function OpenRouter.createAuthKeysCode(
	self: OpenRouter,
	params: {
		callback_url: string,
		code_challenge: string?,
		code_challenge_method: ("S256" | "plain")?,
		limit: number?,
	}
): Types.Result<
	Types.CreateAuthKeysCode200Response,
	Types.CreateAuthKeysCode400Response | Types.CreateAuthKeysCode401Response | Types.CreateAuthKeysCode500Response
>
	return self:_request("POST", "/auth/keys/code", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Chat: Chat completion endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Sends a request for a model response for the given chat conversation. Supports both streaming and non-streaming modes.

    Endpoint: POST /chat/completions

    @method sendChatCompletionRequest
    @within OpenRouter
    @tag Chat
    
    @param params ChatGenerationParams -- Request body parameters
    @return Result<SendChatCompletionRequest200Response, SendChatCompletionRequest400Response | SendChatCompletionRequest401Response | SendChatCompletionRequest429Response | SendChatCompletionRequest500Response>
]=]
function OpenRouter.sendChatCompletionRequest(
	self: OpenRouter,
	params: Types.ChatGenerationParams
): Types.Result<
	Types.SendChatCompletionRequest200Response,
	Types.SendChatCompletionRequest400Response
	| Types.SendChatCompletionRequest401Response
	| Types.SendChatCompletionRequest429Response
	| Types.SendChatCompletionRequest500Response
>
	return self:_request("POST", "/chat/completions", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Completions: Text completion endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Creates a completion for the provided prompt and parameters. Supports both streaming and non-streaming modes.

    Endpoint: POST /completions

    @method createCompletions
    @within OpenRouter
    @tag Completions
    
    @param params CompletionCreateParams -- Request body parameters
    @return Result<CreateCompletions200Response, CreateCompletions400Response | CreateCompletions401Response | CreateCompletions429Response | CreateCompletions500Response>
]=]
function OpenRouter.createCompletions(
	self: OpenRouter,
	params: Types.CompletionCreateParams
): Types.Result<
	Types.CreateCompletions200Response,
	Types.CreateCompletions400Response
	| Types.CreateCompletions401Response
	| Types.CreateCompletions429Response
	| Types.CreateCompletions500Response
>
	return self:_request("POST", "/completions", params)
end

return OpenRouter

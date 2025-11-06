--!strict
-- This file is auto-generated from OpenRouter API
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: 2025-11-06T23:24:28.020291Z

--[[
  OpenRouter API - Generated API Methods
]]

local HttpService = game:GetService("HttpService")
local Types = require(script.types)

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
  Create a response

  Creates a streaming or non-streaming response using OpenResponses API format


  Endpoint: POST /responses
]]
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
  Get user activity grouped by endpoint

  Returns user activity data grouped by endpoint for the last 30 (completed)
  UTC days


  Endpoint: GET /activity
]]
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
  Get remaining credits

  Get total credits purchased and used for the authenticated user


  Endpoint: GET /credits
]]
function OpenRouter.getCredits(self: OpenRouter): Types.Result<
	Types.GetCredits200Response,
	Types.GetCredits401Response | Types.GetCredits403Response | Types.GetCredits500Response
>
	return self:_request("GET", "/credits", nil)
end

--[[
  Create a Coinbase charge for crypto payment

  Create a Coinbase charge for crypto payment


  Endpoint: POST /credits/coinbase
]]
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
  Submit an embedding request

  Submits an embedding request to the embeddings router


  Endpoint: POST /embeddings
]]
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
  Get request & usage metadata for a generation


  Endpoint: GET /generation
]]
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
  Get total count of available models


  Endpoint: GET /models/count
]]
function OpenRouter.listModelsCount(
	self: OpenRouter
): Types.Result<Types.ListModelsCount200Response, Types.ListModelsCount500Response>
	return self:_request("GET", "/models/count", nil)
end

--[[
  List all models and their properties


  Endpoint: GET /models
]]
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

--[[
  List all embeddings models

  Returns a list of all available embeddings models and their properties


  Endpoint: GET /models/embeddings
]]
function OpenRouter.listModelsEmbeddings(self: OpenRouter): Types.Result<
	Types.ListModelsEmbeddings200Response,
	Types.ListModelsEmbeddings400Response | Types.ListModelsEmbeddings500Response
>
	return self:_request("GET", "/models/embeddings", nil)
end

--[[
  List models filtered by user provider preferences


  Endpoint: GET /models/user
]]
function OpenRouter.listModelsUser(self: OpenRouter): Types.Result<
	Types.ListModelsUser200Response,
	Types.ListModelsUser401Response | Types.ListModelsUser500Response
>
	return self:_request("GET", "/models/user", nil)
end

--[[
  List all endpoints for a model


  Endpoint: GET /models/{author}/{slug}/endpoints
]]
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

--[[
  Preview the impact of ZDR on the available endpoints


  Endpoint: GET /endpoints/zdr
]]
function OpenRouter.listEndpointsZdr(
	self: OpenRouter
): Types.Result<Types.ListEndpointsZdr200Response, Types.ListEndpointsZdr500Response>
	return self:_request("GET", "/endpoints/zdr", nil)
end

--[[
  Get a model's supported parameters and data about which are most popular


  Endpoint: GET /parameters/{author}/{slug}
]]
function OpenRouter.getParameters(
	self: OpenRouter,
	author: string,
	slug: string,
	provider: string?
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
  List all providers


  Endpoint: GET /providers
]]
function OpenRouter.listProviders(
	self: OpenRouter
): Types.Result<Types.ListProviders200Response, Types.ListProviders500Response>
	return self:_request("GET", "/providers", nil)
end

--[[
  List API keys


  Endpoint: GET /keys
]]
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

--[[
  Create a new API key


  Endpoint: POST /keys
]]
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

--[[
  Get a single API key


  Endpoint: GET /keys/{hash}
]]
function OpenRouter.getKey(
	self: OpenRouter,
	hash: string
): Types.Result<
	Types.GetKey200Response,
	Types.GetKey401Response | Types.GetKey404Response | Types.GetKey429Response | Types.GetKey500Response
>
	return self:_request("GET", `/keys/{hash}`, nil)
end

--[[
  Delete an API key


  Endpoint: DELETE /keys/{hash}
]]
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

--[[
  Update an API key


  Endpoint: PATCH /keys/{hash}
]]
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

--[[
  Get current API key

  Get information on the API key associated with the current authentication
  session


  Endpoint: GET /key
]]
function OpenRouter.getCurrentKey(self: OpenRouter): Types.Result<
	Types.GetCurrentKey200Response,
	Types.GetCurrentKey401Response | Types.GetCurrentKey500Response
>
	return self:_request("GET", "/key", nil)
end

--[[
  Exchange authorization code for API key

  Exchange an authorization code from the PKCE flow for a user-controlled API
  key


  Endpoint: POST /auth/keys
]]
function OpenRouter.exchangeAuthCodeForAPIKey(
	self: OpenRouter,
	params: {
		code: string,
		code_verifier: string?,
		code_challenge_method: ("Types.S256" | "plain")?,
	}
): Types.Result<
	Types.ExchangeAuthCodeForAPIKey200Response,
	Types.ExchangeAuthCodeForAPIKey400Response
	| Types.ExchangeAuthCodeForAPIKey403Response
	| Types.ExchangeAuthCodeForAPIKey500Response
>
	return self:_request("POST", "/auth/keys", params)
end

--[[
  Create authorization code

  Create an authorization code for the PKCE flow to generate a user-controlled
  API key


  Endpoint: POST /auth/keys/code
]]
function OpenRouter.createAuthKeysCode(
	self: OpenRouter,
	params: {
		callback_url: string,
		code_challenge: string?,
		code_challenge_method: ("Types.S256" | "plain")?,
		limit: number?,
	}
): Types.Result<
	Types.CreateAuthKeysCode200Response,
	Types.CreateAuthKeysCode400Response | Types.CreateAuthKeysCode401Response | Types.CreateAuthKeysCode500Response
>
	return self:_request("POST", "/auth/keys/code", params)
end

--[[
  Create a chat completion

  Sends a request for a model response for the given chat conversation.
  Supports both streaming and non-streaming modes.


  Endpoint: POST /chat/completions
]]
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
  Create a completion

  Creates a completion for the provided prompt and parameters. Supports both
  streaming and non-streaming modes.


  Endpoint: POST /completions
]]
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

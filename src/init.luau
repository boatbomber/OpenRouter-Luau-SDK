--!strict
-- This file is auto-generated from OpenRouter API
-- DO NOT EDIT MANUALLY - Changes will be overwritten
-- Last generated: 2026-01-24T21:38:03.202234Z (generator v1.0.0)
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
  anthropic.messages: anthropic.messages endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Creates a message using the Anthropic Messages API format. Supports text, images, PDFs, tools, and extended thinking.

    Endpoint: POST /messages

    @method createMessages
    @within OpenRouter
    @tag anthropic.messages
    
    @param params AnthropicMessagesRequest -- Request body parameters
    @return Result<CreateMessages200Response, CreateMessages400Response | CreateMessages401Response | CreateMessages403Response | CreateMessages404Response | CreateMessages429Response | CreateMessages500Response | CreateMessages503Response | CreateMessages529Response>
]=]
function OpenRouter.createMessages(
	self: OpenRouter,
	params: Types.AnthropicMessagesRequest
): Types.Result<
	Types.CreateMessages200Response,
	Types.CreateMessages400Response
	| Types.CreateMessages401Response
	| Types.CreateMessages403Response
	| Types.CreateMessages404Response
	| Types.CreateMessages429Response
	| Types.CreateMessages500Response
	| Types.CreateMessages503Response
	| Types.CreateMessages529Response
>
	return self:_request("POST", "/messages", params)
end

--[[
  ══════════════════════════════════════════════════════════════════════════════
  Analytics: Analytics and usage endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    Returns user activity data grouped by endpoint for the last 30 (completed) UTC days. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
    Get total credits purchased and used for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
    
    @param params { input: (string | {string} | {number} | {{number}} | {{ content: {({ ["type"]: "text", text: string } | { ["type"]: "image_url", image_url: { url: string } })} }}), model: string, encoding_format: ("float" | "base64")?, dimensions: number?, user: string?, provider: ProviderPreferences?, input_type: string? } -- Request body parameters
    @return Result<CreateEmbeddings200Response, CreateEmbeddings400Response | CreateEmbeddings401Response | CreateEmbeddings402Response | CreateEmbeddings404Response | CreateEmbeddings429Response | CreateEmbeddings500Response | CreateEmbeddings502Response | CreateEmbeddings503Response | CreateEmbeddings524Response | CreateEmbeddings529Response>
]=]
function OpenRouter.createEmbeddings(
	self: OpenRouter,
	params: {
		input: string | { string } | { number } | { { number } } | {
			{
				content: { { ["type"]: "text", text: string } | { ["type"]: "image_url", image_url: { url: string } } },
			}
		},
		model: string,
		encoding_format: ("float" | "base64")?,
		dimensions: number?,
		user: string?,
		provider: Types.ProviderPreferences?,
		input_type: string?,
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

--[=[
    Returns a list of all available embeddings models and their properties

    Endpoint: GET /embeddings/models

    @method listEmbeddingsModels
    @within OpenRouter
    @tag Embeddings
    
    @return Result<ListEmbeddingsModels200Response, ListEmbeddingsModels400Response | ListEmbeddingsModels500Response>
]=]
function OpenRouter.listEmbeddingsModels(self: OpenRouter): Types.Result<
	Types.ListEmbeddingsModels200Response,
	Types.ListEmbeddingsModels400Response | Types.ListEmbeddingsModels500Response
>
	return self:_request("GET", "/embeddings/models", nil)
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
    
    @param category ("programming" | "roleplay" | "marketing" | "marketing/seo" | "technology" | "science" | "translation" | "legal" | "finance" | "health" | "trivia" | "academia")? -- Filter models by use case category
    @param supported_parameters string? -- No description provided
    @param use_rss string? -- No description provided
    @param use_rss_chat_links string? -- No description provided
    @return Result<GetModels200Response, GetModels400Response | GetModels500Response>
]=]
function OpenRouter.getModels(
	self: OpenRouter,
	category: (
		"programming"
		| "roleplay"
		| "marketing"
		| "marketing/seo"
		| "technology"
		| "science"
		| "translation"
		| "legal"
		| "finance"
		| "health"
		| "trivia"
		| "academia"
	)?,
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
    List models filtered by user provider preferences, [privacy settings](https://openrouter.ai/docs/guides/privacy/logging), and [guardrails](https://openrouter.ai/docs/guides/features/guardrails). If requesting through `eu.openrouter.ai/api/v1/...` the results will be filtered to models that satisfy [EU in-region routing](https://openrouter.ai/docs/guides/privacy/logging#enterprise-eu-in-region-routing).

    Endpoint: GET /models/user

    @method listModelsUser
    @within OpenRouter
    @tag Models
    
    @return Result<ListModelsUser200Response, ListModelsUser401Response | ListModelsUser404Response | ListModelsUser500Response>
]=]
function OpenRouter.listModelsUser(self: OpenRouter): Types.Result<
	Types.ListModelsUser200Response,
	Types.ListModelsUser401Response | Types.ListModelsUser404Response | Types.ListModelsUser500Response
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
    List all API keys for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
    Create a new API key for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /keys

    @method createKeys
    @within OpenRouter
    @tag API Keys
    
    @param params { name: string, limit: number?, limit_reset: ("daily" | "weekly" | "monthly")?, include_byok_in_limit: boolean?, expires_at: string? } -- Request body parameters
    @return Result<CreateKeys201Response, CreateKeys400Response | CreateKeys401Response | CreateKeys429Response | CreateKeys500Response>
]=]
function OpenRouter.createKeys(
	self: OpenRouter,
	params: {
		name: string,
		limit: number?,
		limit_reset: ("daily" | "weekly" | "monthly")?,
		include_byok_in_limit: boolean?,
		expires_at: string?,
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
    Get a single API key by hash. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
    Delete an existing API key. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
    Update an existing API key. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

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
  Guardrails: Guardrails endpoints
  ══════════════════════════════════════════════════════════════════════════════
]]

--[=[
    List all guardrails for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails

    @method listGuardrails
    @within OpenRouter
    @tag Guardrails
    
    @param limit string? -- Maximum number of records to return (max 100)
    @param offset string? -- Number of records to skip for pagination
    @return Result<ListGuardrails200Response, ListGuardrails401Response | ListGuardrails500Response>
]=]
function OpenRouter.listGuardrails(
	self: OpenRouter,
	limit: string?,
	offset: string?
): Types.Result<
	Types.ListGuardrails200Response,
	Types.ListGuardrails401Response | Types.ListGuardrails500Response
>
	local queryString = self:_buildQueryString({
		["limit"] = limit,
		["offset"] = offset,
	})
	return self:_request("GET", `/guardrails{queryString}`, nil)
end

--[=[
    Create a new guardrail for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /guardrails

    @method createGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param params { name: string, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean? } -- Request body parameters
    @return Result<CreateGuardrail201Response, CreateGuardrail400Response | CreateGuardrail401Response | CreateGuardrail500Response>
]=]
function OpenRouter.createGuardrail(
	self: OpenRouter,
	params: {
		name: string,
		description: string?,
		limit_usd: number?,
		reset_interval: ("daily" | "weekly" | "monthly")?,
		allowed_providers: { string }?,
		allowed_models: { string }?,
		enforce_zdr: boolean?,
	}
): Types.Result<
	Types.CreateGuardrail201Response,
	Types.CreateGuardrail400Response | Types.CreateGuardrail401Response | Types.CreateGuardrail500Response
>
	return self:_request("POST", "/guardrails", params)
end

--[=[
    Get a single guardrail by ID. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails/{id}

    @method getGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail to retrieve
    @return Result<GetGuardrail200Response, GetGuardrail401Response | GetGuardrail404Response | GetGuardrail500Response>
]=]
function OpenRouter.getGuardrail(
	self: OpenRouter,
	id: string
): Types.Result<
	Types.GetGuardrail200Response,
	Types.GetGuardrail401Response | Types.GetGuardrail404Response | Types.GetGuardrail500Response
>
	return self:_request("GET", `/guardrails/{id}`, nil)
end

--[=[
    Delete an existing guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: DELETE /guardrails/{id}

    @method deleteGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail to delete
    @return Result<DeleteGuardrail200Response, DeleteGuardrail401Response | DeleteGuardrail404Response | DeleteGuardrail500Response>
]=]
function OpenRouter.deleteGuardrail(
	self: OpenRouter,
	id: string
): Types.Result<
	Types.DeleteGuardrail200Response,
	Types.DeleteGuardrail401Response | Types.DeleteGuardrail404Response | Types.DeleteGuardrail500Response
>
	return self:_request("DELETE", `/guardrails/{id}`, nil)
end

--[=[
    Update an existing guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: PATCH /guardrails/{id}

    @method updateGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail to update
    @param params { name: string?, description: string?, limit_usd: number?, reset_interval: ("daily" | "weekly" | "monthly")?, allowed_providers: {string}?, allowed_models: {string}?, enforce_zdr: boolean? } -- Request body parameters
    @return Result<UpdateGuardrail200Response, UpdateGuardrail400Response | UpdateGuardrail401Response | UpdateGuardrail404Response | UpdateGuardrail500Response>
]=]
function OpenRouter.updateGuardrail(
	self: OpenRouter,
	id: string,
	params: {
		name: string?,
		description: string?,
		limit_usd: number?,
		reset_interval: ("daily" | "weekly" | "monthly")?,
		allowed_providers: { string }?,
		allowed_models: { string }?,
		enforce_zdr: boolean?,
	}
): Types.Result<
	Types.UpdateGuardrail200Response,
	Types.UpdateGuardrail400Response
	| Types.UpdateGuardrail401Response
	| Types.UpdateGuardrail404Response
	| Types.UpdateGuardrail500Response
>
	return self:_request("PATCH", `/guardrails/{id}`, params)
end

--[=[
    List all API key guardrail assignments for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails/assignments/keys

    @method listKeyAssignments
    @within OpenRouter
    @tag Guardrails
    
    @param limit string? -- Maximum number of records to return (max 100)
    @param offset string? -- Number of records to skip for pagination
    @return Result<ListKeyAssignments200Response, ListKeyAssignments401Response | ListKeyAssignments500Response>
]=]
function OpenRouter.listKeyAssignments(
	self: OpenRouter,
	limit: string?,
	offset: string?
): Types.Result<
	Types.ListKeyAssignments200Response,
	Types.ListKeyAssignments401Response | Types.ListKeyAssignments500Response
>
	local queryString = self:_buildQueryString({
		["limit"] = limit,
		["offset"] = offset,
	})
	return self:_request("GET", `/guardrails/assignments/keys{queryString}`, nil)
end

--[=[
    List all organization member guardrail assignments for the authenticated user. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails/assignments/members

    @method listMemberAssignments
    @within OpenRouter
    @tag Guardrails
    
    @param limit string? -- Maximum number of records to return (max 100)
    @param offset string? -- Number of records to skip for pagination
    @return Result<ListMemberAssignments200Response, ListMemberAssignments401Response | ListMemberAssignments500Response>
]=]
function OpenRouter.listMemberAssignments(
	self: OpenRouter,
	limit: string?,
	offset: string?
): Types.Result<
	Types.ListMemberAssignments200Response,
	Types.ListMemberAssignments401Response | Types.ListMemberAssignments500Response
>
	local queryString = self:_buildQueryString({
		["limit"] = limit,
		["offset"] = offset,
	})
	return self:_request("GET", `/guardrails/assignments/members{queryString}`, nil)
end

--[=[
    List all API key assignments for a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails/{id}/assignments/keys

    @method listGuardrailKeyAssignments
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param limit string? -- Maximum number of records to return (max 100)
    @param offset string? -- Number of records to skip for pagination
    @return Result<ListGuardrailKeyAssignments200Response, ListGuardrailKeyAssignments401Response | ListGuardrailKeyAssignments404Response | ListGuardrailKeyAssignments500Response>
]=]
function OpenRouter.listGuardrailKeyAssignments(
	self: OpenRouter,
	id: string,
	limit: string?,
	offset: string?
): Types.Result<
	Types.ListGuardrailKeyAssignments200Response,
	Types.ListGuardrailKeyAssignments401Response
	| Types.ListGuardrailKeyAssignments404Response
	| Types.ListGuardrailKeyAssignments500Response
>
	local queryString = self:_buildQueryString({
		["limit"] = limit,
		["offset"] = offset,
	})
	return self:_request("GET", `/guardrails/{id}/assignments/keys{queryString}`, nil)
end

--[=[
    Assign multiple API keys to a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /guardrails/{id}/assignments/keys

    @method bulkAssignKeysToGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param params { key_hashes: {string} } -- Request body parameters
    @return Result<BulkAssignKeysToGuardrail200Response, BulkAssignKeysToGuardrail400Response | BulkAssignKeysToGuardrail401Response | BulkAssignKeysToGuardrail404Response | BulkAssignKeysToGuardrail500Response>
]=]
function OpenRouter.bulkAssignKeysToGuardrail(
	self: OpenRouter,
	id: string,
	params: { key_hashes: { string } }
): Types.Result<
	Types.BulkAssignKeysToGuardrail200Response,
	Types.BulkAssignKeysToGuardrail400Response
	| Types.BulkAssignKeysToGuardrail401Response
	| Types.BulkAssignKeysToGuardrail404Response
	| Types.BulkAssignKeysToGuardrail500Response
>
	return self:_request("POST", `/guardrails/{id}/assignments/keys`, params)
end

--[=[
    List all organization member assignments for a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: GET /guardrails/{id}/assignments/members

    @method listGuardrailMemberAssignments
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param limit string? -- Maximum number of records to return (max 100)
    @param offset string? -- Number of records to skip for pagination
    @return Result<ListGuardrailMemberAssignments200Response, ListGuardrailMemberAssignments401Response | ListGuardrailMemberAssignments404Response | ListGuardrailMemberAssignments500Response>
]=]
function OpenRouter.listGuardrailMemberAssignments(
	self: OpenRouter,
	id: string,
	limit: string?,
	offset: string?
): Types.Result<
	Types.ListGuardrailMemberAssignments200Response,
	Types.ListGuardrailMemberAssignments401Response
	| Types.ListGuardrailMemberAssignments404Response
	| Types.ListGuardrailMemberAssignments500Response
>
	local queryString = self:_buildQueryString({
		["limit"] = limit,
		["offset"] = offset,
	})
	return self:_request("GET", `/guardrails/{id}/assignments/members{queryString}`, nil)
end

--[=[
    Assign multiple organization members to a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /guardrails/{id}/assignments/members

    @method bulkAssignMembersToGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param params { member_user_ids: {string} } -- Request body parameters
    @return Result<BulkAssignMembersToGuardrail200Response, BulkAssignMembersToGuardrail400Response | BulkAssignMembersToGuardrail401Response | BulkAssignMembersToGuardrail404Response | BulkAssignMembersToGuardrail500Response>
]=]
function OpenRouter.bulkAssignMembersToGuardrail(
	self: OpenRouter,
	id: string,
	params: { member_user_ids: { string } }
): Types.Result<
	Types.BulkAssignMembersToGuardrail200Response,
	Types.BulkAssignMembersToGuardrail400Response
	| Types.BulkAssignMembersToGuardrail401Response
	| Types.BulkAssignMembersToGuardrail404Response
	| Types.BulkAssignMembersToGuardrail500Response
>
	return self:_request("POST", `/guardrails/{id}/assignments/members`, params)
end

--[=[
    Unassign multiple API keys from a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /guardrails/{id}/assignments/keys/remove

    @method bulkUnassignKeysFromGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param params { key_hashes: {string} } -- Request body parameters
    @return Result<BulkUnassignKeysFromGuardrail200Response, BulkUnassignKeysFromGuardrail400Response | BulkUnassignKeysFromGuardrail401Response | BulkUnassignKeysFromGuardrail404Response | BulkUnassignKeysFromGuardrail500Response>
]=]
function OpenRouter.bulkUnassignKeysFromGuardrail(
	self: OpenRouter,
	id: string,
	params: { key_hashes: { string } }
): Types.Result<
	Types.BulkUnassignKeysFromGuardrail200Response,
	Types.BulkUnassignKeysFromGuardrail400Response
	| Types.BulkUnassignKeysFromGuardrail401Response
	| Types.BulkUnassignKeysFromGuardrail404Response
	| Types.BulkUnassignKeysFromGuardrail500Response
>
	return self:_request("POST", `/guardrails/{id}/assignments/keys/remove`, params)
end

--[=[
    Unassign multiple organization members from a specific guardrail. [Provisioning key](/docs/guides/overview/auth/provisioning-api-keys) required.

    Endpoint: POST /guardrails/{id}/assignments/members/remove

    @method bulkUnassignMembersFromGuardrail
    @within OpenRouter
    @tag Guardrails
    
    @param id string -- The unique identifier of the guardrail
    @param params { member_user_ids: {string} } -- Request body parameters
    @return Result<BulkUnassignMembersFromGuardrail200Response, BulkUnassignMembersFromGuardrail400Response | BulkUnassignMembersFromGuardrail401Response | BulkUnassignMembersFromGuardrail404Response | BulkUnassignMembersFromGuardrail500Response>
]=]
function OpenRouter.bulkUnassignMembersFromGuardrail(
	self: OpenRouter,
	id: string,
	params: { member_user_ids: { string } }
): Types.Result<
	Types.BulkUnassignMembersFromGuardrail200Response,
	Types.BulkUnassignMembersFromGuardrail400Response
	| Types.BulkUnassignMembersFromGuardrail401Response
	| Types.BulkUnassignMembersFromGuardrail404Response
	| Types.BulkUnassignMembersFromGuardrail500Response
>
	return self:_request("POST", `/guardrails/{id}/assignments/members/remove`, params)
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
    
    @param params { callback_url: string, code_challenge: string?, code_challenge_method: ("S256" | "plain")?, limit: number?, expires_at: string? } -- Request body parameters
    @return Result<CreateAuthKeysCode200Response, CreateAuthKeysCode400Response | CreateAuthKeysCode401Response | CreateAuthKeysCode500Response>
]=]
function OpenRouter.createAuthKeysCode(
	self: OpenRouter,
	params: {
		callback_url: string,
		code_challenge: string?,
		code_challenge_method: ("S256" | "plain")?,
		limit: number?,
		expires_at: string?,
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

return OpenRouter

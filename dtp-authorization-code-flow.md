%%%
title = "Digital Trust Protocol Authorization Code Flow"
abbrev = "dtp-auth-code"
ipr = "trust200902"
area = "Identity"
workgroup = "connect"
keyword = ["security", "openid", "authorization", "trust"]

date = 2020-03-19T12:00:00Z

[seriesInfo]
name = "Internet-Draft"
value = "dtp-auth-code-00"
status = "standard"

[[author]]
initials="A."
surname="Pulido"
fullname="Alberto Pulido Moyano"
organization="Santander Technology"
    [author.address]
    email = "alberto.pulido@santander.co.uk"

[[author]]
initials="V."
surname="Herraiz"
fullname="Victor Herraiz Posada"
organization="Santander Technology"
    [author.address]
    email = "victor.herraiz@santander.co.uk"

[[author]]
initials="M."
surname="Herrero"
fullname="Miguel Revesado"
organization="Santander Technology"
    [author.address]
    email = "miguel.revesado@santander.co.uk"

[[author]]
initials="J."
surname="Oliva, Ed."
fullname="Jorge Oliva Fernandez"
organization="Santander Technology"
    [author.address]
    email = "Jorge.OlivaFernandez@santander.co.uk"

[[author]]
initials="D."
surname="Bianchini"
fullname="Davide Bianchini"
organization="Santander Technology"
    [author.address]
    email = "davide.bianchini@santander.co.uk"

%%%

.# Abstract

This document defines the Digital Trust Protocol authorization code flow, which allows End-Users share verified information with Clients in a secure way using OIDC and OAuth 2.0 protocols.

{mainmatter}

# Introduction {#Introduction}

Privacy is one of the most important things of our lives, thanks to the grown of online services we have improved our day to day, but we are losing our privacy, while services are relying in non trusted data that allows the creation of fake identities in the internet.

Most of the services require private information that is introduced by the user, making users spread the same details around the different service providers while not allowing these service providers to verify the information filled by customers. We believe that this is inefficient for both parties.

We want to define a way that will help customers to share the minimum required level of details while allow services to get rich and trusted information from the customer, preserving and avoiding the risk of storing sensitive information.

OIDC provides a mechanism to verify identity of the End-User based on authentication performed by an Auth Server and get Basic profile information. We would like to use this mechanism in order to provide certified information by a secure communication protocol, to achieve this we will use OpenId as base.

The specification depicted in this document covers only the security profile for Digital Trust Protocol, other extensions will also complement the full protocol specifications.

## Notational conventions

The key words "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "MAY", and "CAN" in this document are to be interpreted as described in "Key words for use in RFCs to Indicate Requirement Levels" [@!RFC2119]. These key words are not used as dictionary terms such that any occurrence of them shall be interpreted as key words and are not to be interpreted with their natural language meanings

## Terminology

This specification uses the terms "Access Token", "Authorization Code", "Authorization Endpoint", "Authorization Grant", "Authorization Server", "Client", "Client Authentication", "Client Identifier", "Client Secret", "Grant Type", "Protected Resource", "Redirection URI", "Refresh Token",  "Response Type", and "Token Endpoint" defined by [@!OAuth2.0], the terms "Claim Name", "Claim Value" and "JSON Web Token (JWT)" defined by [@!JWT], the terms "Header Parameter", "JOSE Header" and "JSON Web Signature (JWS)" defined by [@!JWS], the term "User Agent" defined by [@!RFC2616], and the term "Response Mode" defined by [@!OAuth.Multiple.Responses], and terms "Authentication", "Authentication Request", "Authorization Request", "Claim", "Claim Type", "Claims Provider", "Credential", "End-User", "Entity", "ID Token", "Identifier", "Identity", "Issuer", "OpenID Provider (OP)", "Request Object", "Request URI", "Relying Party (RP)", "UserInfo Endpoint", "Validation", "Verification" defined by OpenID Connect [@!OIDC]

This specification also use to the following terms:

OpenID
: References to "openid" in this documentation are about OpenID connect specification [@!OIDC]

# DTP Authorization Code flow

This section describes how to perform a customer information share using the Authorization Code Flow, this flow is based on "Authentication using the Authorization Code Flow" Section 3.1 of [@!OIDC] specification with some add ons and changes to fulfil our requirements, with customer privacy control and security best practices.

## Authorization Code Flow Steps

These steps of the flow are illustrated in the following diagram:
!---
![svg](DiagramRFC.svg "Diagram")
!---

[Diagram Source Here](http://www.plantuml.com/plantuml/uml/XLFHRjiw37ttL_0n1b8aj_Tbo9QXGHPi7OhPQBBrCL0bDXPgIvb4T-s-nj_YBnlbHe6zP9kV3F6SG_AGlF8a7DLLcNWfIeHAFCERwHH-Q4L58YHP1ylQawtG9SdAaAONkCsFlrcUy3UVynlSuRtNX9F5VW_pUPBmqyNx8tisY0l_gCqE7bXU2H994c5COQqPoC9QZv0x-wGLkfZZ5h_Nw2dglsDqnkYL9t5VQbz0LLCjIjZSh6C176-RjicpzGOcscZIWl12r5HOftyYZ6IfqH18XmeDHqi_1dV8y_bkdIP9bhVD8TCtKMh50h1W0LXsrBE0A74-k9PsZnxi0r1nXC98UAY4OOHrBoai2vIFeMifJCG4l4TGI4ANVY2-TDZBkwsTXj7Nsoyfi29ubiJGJg2mBMqJNFwqsUHmEVslJngt3JxljKE_rQRp_JYRXPIu9n-dS7RA_qyluSPAGTgQ6KoEFh-DHb-hSJzTEfnzblT9V-PaUKHdzoIqwKyCQi_BrIT4_606hzAQfNsOHiYWj4CPNUWfjaslojUbWrct0a511hNHZTrfavxWPWVNG5hZ6GqJM6F9MK0RNl-gCmh8WY-4mmaib88FWiHnzVkrTrECIXpuc_V3TfWg2CVCLGYZQ727l0XlwUa9VbnjO03S1k11AGm-0jlcANhQnUAnRkmZ6hWsX4uMmkpmjxDjct_SBRmUBGMTitTwjhvXtpid3BtiSNOA7Lxsqvd3ZHrgjJqK4TRBEjw9LJfc7wL4xoSE7npw8askqAYwAdy1)

The Authorization Code Flow goes through the following steps: (separated in groups as in the flow diagram)

### RP website/APP Flow Steps

This is the start of the process, can be initiated and presented to the customer in many different ways but common steps are:

1. Customer is navigating in a RP website or using an RP app.
2. RP website/app asks for a certified data to the customer and offers the different providers that are integrated in the RP implementation.
3. Customer selects a provider to provide the requested information.

### RP Request Flow Steps

Once the RP gets the provider selected by the customer the steps to initiate the information interchange are:

1. It is RECOMMENDED that RP and OP establish a mutual TLS connection, if not possible communication with the Authorization Server MUST utilize TLS. See Section 16.17 of [@!OIDC] for more information on using TLS.
2. RP sends the request to the Initiate Authorization endpoint in OP to initiate the process, the auhtorization data is sent inside a request object as described in section [Initiate Authorization Request](#initi-auth-req) of this specification.
3. OP MUST validate that the client is correctly authenticate and MUST validate the request object as described in Section 3.1.2.2. of [@!OIDC], additionally MUST validate the `request` JWS following Section 6.3. of [@!OIDC] specification.
4. If validations are correct the OP MUST store the JWS and generate a `request_uri` that identify where is located. As described in [@!OAuth.PAR] specification.
5. OP will return to the RP a response with the format described in section [Successful Initiate Authorization Response](#succ-init-auth-resp) of this specification.
6. In case of any error OP will return an error response as described in section [Initiate Authorization Error Response](#err-init-auth-resp) of this specification.

### Customer Accepts Request Flow Steps

Once the OP has validated the request JWS from RP, the user authentication and consent flow continues as follow:

1. RP responds to the user with a HTTP 302 redirect response as described in Section 3.1.2.1 of [@!OIDC], containing in Location header the url with the needed params to make an authentication Request to OP. An example of this response can be found in [Authorize redirect response](#auth-redirect-resp)
2. The customer User Agent follows the redirection and make an Authentication Request to the Authorization Endpoint in OP. Example of the request: [Authentication request](#auth-req).
3. OP MUST obtain the request JWS from storage using the `request_uri` parameter, OP MUST check that `request_uri` is still valid and not expired.
4. OP then MUST validate the request as described in Section 3.1.2.2. of [@!OIDC], OP MUST be aware that even if the `request_uri` parameter is used, parameters MAY also be passed using the OAuth 2.0 request syntax, parameter values contained in the referenced JWT supersede those passed using the OAuth 2.0 request syntax, as described in Section 6.2. of [@!OIDC].
5. If the request is valid, the OP attempts to Authenticate the End-User or determines whether the End-User is Authenticated, the way to authenticate the user (user, password, 2FA, cookies... ) is out of the scope of this specification. The normal approach is to present the user one or more pages (steps auth) to authenticate the user. More details in Section 3.1.2.3. of [@!OIDC].
6. Once customer is authenticated, the Authorization Server MUST obtain an authorization decision before releasing information to the RP, as described in Section 3.1.2.4. of [@!OIDC]. The OP will present an interactive dialog to the customer explaining what are the claims requested by the RP, RP MAY show the data that is going to be share in order to help End-user to take a decision, in this case please follow the security recommendations described in section [Security Considetarions](#security-considerations). The customer then accepts or selects information to share with the RP.
7. Once customer consents the request, OP will store the consent information (which claims has been consented) and generates an authorization code.
8. OP responds to the user with a HTTP 302 redirect response, with Location header pointing to the `redirect_uri` and as query parameter the generated `code`, as described in Section 3.1.2.5. of [@!OIDC]. Example of the response: [Successful Authorize response](#succ-auth-resp).
9. In case of any error OP will return an error response as described in section [Error Response](#err-resp), and will use the error codes from Section 3.1.2.6 of [@!OIDC].
10. The customer User Agent follows the redirection and makes a request to the RP callback uri, providing the authorization code in the query string, example of the request: [Callback RP request](#callback-req).
11. RP MUST validate the authorization response following Section 3.1.2.7. of [@!OIDC] specification.

### RP Token Interchange Flow Steps

If the RP obtains the consent from the customer in form of authorization `code`, the token interchange process continue with these steps:

1. Is RECOMMENDED that RP and OP establish a mutual TLS connection, if not possible communication with the Authorization Server MUST utilize TLS. See Section 16.17 of [@!OIDC] for more information on using TLS.
2. RP sends a token request to the OP `/token` endpoint containing the authorization `code`, following the specification described in the section 3.1.3.1. of [@!OIDC]. An example of this request in section [Token request](#token-req)
3. OP MUST validate that the client is correctly authenticate and MUST validate the request following the specification in Section 3.1.3.2. of [@!OIDC]. In case of any error OP will return an error response as described in section [Error Response](#err-resp), and will use the error codes from Section 3.1.3.4. of [@!OIDC]
4. If validations are correct OP returns a successful response that includes an `id_token` and an `access_token` as described in Section 3.1.3.3. of [@!OIDC]. An example of response: [Token response](#token-resp). RP must validate the token response as described in Section 3.1.3.5 of [@!OIDC].

# Initiate Authorization Endpoint {#init-auth-endpoint}

This endpoint is a profile of the specification defined in OAuth 2.0 Pushed Authorization Requests [@!OAuth.PAR], see Section [PAR Restrictions and Extension](#par-rest-ext) for more info about differences with the PAR specification.

Initiate Authorization endpoint performs the validation of the request and stores the JWS that is going to be referenced as `request_uri` in the Authorization Request.

## Initiate Authorization Request {#initi-auth-req}

Initiate Authorization Request follow the specification described in Section 2.1. of [@!OAuth.PAR].

OP MUST support the use of the HTTP POST method defined in [@!RFC2616] at the Initiate Authorization Endpoint. The Client uses a HTTPS POST to send a parameter `request` with a signed JWT that should contain the data explained in section 3.1.2.1 of [@!OIDC]. Request parameters are serialized using Form Serialization as described in section 13.2. of [@!OIDC]. This JWT is a "Request Object" as described in Section 6 of [@!OIDC].

The Client MUST authenticate with the Initiate Authorization Endpoint using the authentication method registered for its `client_id`, as described in Section [Client Authentication Methods.](#client-auth-methods)

The following is a non-normative example of a Initiate Authorization Request. (line wraps within JWS for display purposes only)

```
POST /initiate-authorize HTTP/1.1
Host: op.example.com
Content-Type: application/x-www-form-urlencoded

 request=eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6InJwX2tleV8yIn0.eyJpc3MiOiIzZGZkODllMS05NjRiLTRhYzQtYmE0Ni05NzdmYzVmODdkYjk
iLCJhdWQiOiJodHRwczovL29wLmV4YW1wbGUuY29tIiwicmVzcG9uc2VfdHlwZSI6ImNvZGUiLCJjbGllbnRfaWQiOiIzZGZkODllMS05NjRiLTRhYzQtYm
E0Ni05NzdmYzVmODdkYjkiLCJyZWRpcmVjdF91cmkiOiJodHRwczovL3JwLmV4YW1wbGUub3JnL2NiIiwic2NvcGUiOiJvcGVuaWQiLCJzdGF0ZSI6ImFmM
GlmanNsZGtqIiwibm9uY2UiOiJuLTAxMF9NMTZVMzEiLCJjbGFpbXMiOnsiaWRfdG9rZW4iOnsiZ2l2ZW5fbmFtZSI6eyJlc3NlbnRpYWwiOnRydWV9LCJm
YW1pbHlfbmFtZSI6eyJlc3NlbnRpYWwiOnRydWV9LCJwYXNzcG9ydF9udW1iZXIiOm51bGwsIm5hdGlvbmFsaXR5IjpudWxsLCJiaXJ0aGRhdGUiOnsiZXN
zZW50aWFsIjp0cnVlfSwicGxhY2Vfb2ZfYmlydGgiOm51bGx9fSwiaWF0IjoxNTY4NzI0OTQ5LCJuYmYiOjE1Njg3MjQ5NDksImV4cCI6MTU2ODcyNTAwOS
wianRpIjoiYTMyNGM5YWMtYTQ3Yy00MWE4LWFkM2ItMDY5M2IxODE3ZGM5In0.EojFJ5r_FgDGcQS9kjKgwgs759DN6MlS9di_LCnwN2le0PFo51fVYKLwu
pIfnCduY_i2iPgVuCMlx9UM5WV9FdogDf-r1BoF-cp9FLCCd8x-C9VIXKHTXO5jkQ-6jiOG1X00gK7s9-zL7DGlFjXYy8FKiyB1ByZ3onEI4IFFCnJyq3PuTK6UqIYVOOsQ_JgkQvtSdRFVF3jQUzT5bcZb8vGhLL8LGRktfa7CtI-6iHkZzRvcyQvB65hT3yUsC7qxA8UHazHN4n8jIh_vjoMmopMNhFnRzUdEQyuF5l25uJkr5gYbzcrzJPA0byTp4h186muiAxQKWookHSIUNO-ubQ
 &client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer
 &client_assertion=eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6InJwX3NlY19rZXkifQ.eyJpc3MiOiIzZGZkODllMS05NjRiL
TRhYzQtYmE0Ni05NzdmYzVmODdkYjkiLCJhdWQiOiJodHRwczovL29wLmV4YW1wbGUub3JnLyIsInN1YiI6IjNkZmQ4OWUxLTk2NGItNGFjNC1i
YTQ2LTk3N2ZjNWY4N2RiOSIsImlhdCI6MTU3MDAyMjU3NiwibmJmIjoxNTcwMDIyNTc2LCJleHAiOjE1NzAwMjI2MzYsImp0aSI6IjcwMzNhMDV
lLWQyOGEtNGMwMi04ZTZiLWUzZDI2YzRjZTk5MyJ9.N_sUjuLY9CrGFSLIiow-2I6zqtdCPUMt31St9rQCK9nDmglkyyCj3ZJvvxjNE-c6H6wK7
mEbL5d1StP1dhK7iARAkDH-7Jm-CxmcnmvbiqINkVjjkzrww3BMfwa87MPXga7C8-5u8VXokbfiCflqFKbQFbKK7MjCz34loM6Mj6fHkV4HYNVD
zAZv7zPKqjk-WRDJtVRjB2ON0ibVjEL-iNdZQLyN7nm8rto3xB7af5wfTJuvsXIIC1G--vHUZ6A9IxP84fR636IxSSUo8Y76Bp4ShmfqeD0jvTn
er1U2j77B_X01_3gbLAk6Gz48CPfZsDC6c6jW56mt99YZvjf5DQ
```
  
## Initiate Authorization Request Validation

The Authorization Server MUST validate the request received as follows:

1. The Authorization Server MUST verify that Client authentication is valid.
2. The Authorization Server MUST verify that the request fulfils all validations described in section 3.1.2.2 of [@!OIDC].
3. The Authorization Server MUST verify that the request object is a valid JWS, the signature algorithm is not `none`, and the signature is correct as in section 6.3 of [@!OIDC].
4. The Authorization Server MUST verify that Client is asking for user claims using scopes (including scope templates) or claims parameter, as described in section 5.4. and 5.5. of [@!OIDC].

If the Authorization Server encounters any error, it MUST return an error response, as per Section [Initiate Authorization Error Response]({#err-init-auth-resp}) in this document.

## Successful Initiate Authorization Response {#succ-init-auth-resp}

If the verification is successful, the authorization server shall generate a request URI and return a JSON payload that contains `request_uri` and `expires_in` claims at the top level with 201 Created HTTP response code, as described in Section 2.2. of [@!OAuth.PAR].

The `request_uri` shall be based on a cryptographic random value so that it is difficult to predict for an attacker. The request URI shall be bound to the client identifier of the client that posted the request object. Since the request URI can be replayed, its lifetime should be short and preferably limited to one-time use.

The value of these claims in the JSON payload shall be as follows:

* `request_uri`: The request URI corresponding to the request object posted.
* `expires_in`: A JSON number that represents the lifetime of the request URI in seconds. The request URI lifetime is at the discretion of the OP.
* `errors`: See section [errors member in Successful Initiate Authorization Response](#error-member) for more info about this field.

The following is a non-normative example of a Initiate Authorization Successful Response:

```
HTTP/1.1 201 Created
Date: Tue, 2 May 2017 15:22:31 GMT
Content-Type: application/json

{
    "request_uri": "urn:example:Y7AyOKAK",
    "expires_in": 3600,
	"errors": { "group": "id_token","key": "familo_name","description": "unknown claim."}
}
```

Note that `request_uri` can be either URL or URN, within this spec it is hosted by the authorization server. The advantage of the authorization server hosting the request object is that it does not have to support outbound requests to a client specified request URI nor rely on the entropy of the URI for the confidentiality of the request object.

When the request object is stored at the authorization server, the `request_uri` value typically is a [@!URN].

## Initiate Authorization Error Response {#err-init-auth-resp}

A Initiate Authorization Error Response is an OAuth 2.0 Authorization Error Response message returned from the OP's Authorization Endpoint in response to the Initiate Authorization Request message sent by the RP. The error response will follow the specification described in Section [Error Response](#err-resp).

In addition to the error codes defined in Section 4.1.2.1 of OAuth 2.0 Authorization Framework [@!OAuth2.0], this specification also defines the following error codes:

* `invalid_request_object`: The parameters inside the request object are invalid, is signed with none algorithm or the signature is not correct.
* `invalid_request`: The request not contain the parameter `request`.
* `method_not_allowed`: If the request was not POST, the authorization server MUST return a HTTP 405 Method Not Allowed status code.
* `too_many_request`: If the request from the client per a time period goes beyond the number the authorization server allows. the authorization server MUST return a HTTP 429 Too Many Requests status code.

The following is a non-normative example of an Initiate Authorization Error Response:

```
HTTP/1.1 400 Bad Request
Content-Type: application/json
Cache-Control: no-store
Pragma: no-cache

{
 "error": "invalid_request_object",
 "error_description": "Incorrect signature"
}
```

## Initiate Authorization Response Validation

The Client MUST validate that the Inititate Authorization Response contains a valid `request_uri` and `expires_in` parameters.

## _errors_ member in Successful Initiate Authorization Response {#error-member}

This specification add an additional field called `errors` in the successful response of the initiate authorize response, the original fields (`request_uri` and `expires_in`) are described in in Section 2.2. of [@!OAuth.PAR].

`errors` member is an OPTIONAL field of type array that contain a list of errors that are detected in the `claims` request parameter (see section 5.5. of [@!OIDC].

The purpose of this new field is to avoid the RP wait until the end of the process when exchange the code for the `id_token` in the `/token` endpoint or when obtain the claims in the user info endpoint using the `access_token` to know about an error in the request syntax, this fields give the RP a quick feedback in the success response, this means that RP can continue with the process but is already aware about the problem.

The following is a non-normative example of a `errors` member structure

```
"errors": [
	{ 
		"group": "id_token",
		"key": "familo_name",
		"description": "unknown claim."
	},
	{
		"group": "userinfo",
		"key": "given_name",
		"description": "unknown member inside claim"
	}
]
```

Each array object contain the next fields:

* `group`: The group `id_token` or `userinfo` where claim is requested.
* `key`: The claim name that contain the problem.
* `description`: An error description to help RP developer.

## PAR Restrictions and Extension {#par-rest-ext}

The Initiate Authorization Endpoint has some restrictions or add ons to the original specification described in [@!OAuth.PAR].

1. The endpoint recommended name is `/initiate-authorize`.
2. OP SHALL require the use of a request object sent in the request parameter.
3. OP SHALL support only signed JWT request objects, this means OP SHALL REQUIRE request parameter.
4. OP SHALL ONLY allow _response\_type_ with value `code`.
5. OP SHALL only support the client authentication methods described in Section [Client Authentication Methods](#client-auth-methods).
6. OP MAY NOT implement the error validation described in Section "2.3.1.5. Request entity too large" of [@!OAuth.PAR].
7. OP SHALL REQUIRE scope param contain value `openid`.
8. OP MAY return the `errors` field in the Successful Initiate Authorization Response to help RP.

# txn Claim

As part of this specification a new claim called txn should be introduced by the OP in all the `id_tokens` generated and also in the `/userinfo` endpoint responses, this claim as defined in [@!RFC8417] is used in the context of this extension to build audit trails across the parties involved in an OpenID Connect transaction.

This transaction data MUST be stored as long as it is required to store transaction data for auditing purposes by the respective regulation.

The `txn` value MUST allow an RP to obtain these transaction details if needed.  

Note: The mechanism to obtain the transaction details from the OP and their format is out of scope of this specification.

# OpenID Restrictions and Extensions

## Client (aka RP)`

A client specification statements are:

1. MAY support mutual TLS connections.
2. if mutual TLS is not possible, client SHALL communicate with the Authorization Server using TLS. See Section 16.17 of [@!OIDC] for more information on using TLS.
3. SHALL authenticate when making requests to the Authentication Server at the `/token` and `/initiate-authorize` endpoint, as described in Section [Client Authentication Methods](#client-auth-methods).
4. SHALL include the `request_uri` parameter as defined in Section 6 of [@!OIDC] in the authentication request;
5. SHALL additionally send duplicates of the parameters/values using the OAuth 2.0 request syntax where required by the OAuth specification.
6. SHALL use the initiate authorize endpoint before call the authentication request, as described in section [Initiate Authorization Endpoint](#init-auth-endpoint) of this specification.
7. SHALL sign the JWT request object sent to initiate authorize endpoint, as described in Section 6.1. of [@!OIDC].
8. SHALL NOT use `none` algorithm in JWT.
9. SHALL require and validate JWS signed ID Token be returned from token endpoint.
10. SHALL include the `nonce` parameter in authentication request, as described in in Section 3.1.2.1 of [@!OIDC],
11. Is RECOMMENDED to include the `state` parameters in authentication request, as described in Section _3.1.2.1_ of [@!OIDC],
12. SHALL use as preferred method for request claims the `claims` parameter inside the JWT request Object as described in section 5.5. of [@!OIDC]
13. MAY use scopes templates as an alternative to request claims.
14. SHALL include `openid` value as scope in all authorization request.
15. SHALL use the PCKE as described in [@!OAuth.NativeApps] for native apps clients.

## Authentication server (aka OP)

The authorization server specification statements are:

1. SHALL NOT support public clients.
2. MAY support mutual TLS connections.
3. if mutual TLS is not possible, Authorization Server SHALL require use of TLS in the endpoints. See Section 16.17 of [@!OIDC] for more information on using TLS.
4. SHALL validate for `/token` and `/initiate-authorize` endpoint that Client is authenticated, as described in Section [Client Authentication Methods](#client-auth-methods).
5. SHALL require the `response_type` values `code`;
6. SHALL require signed JWT request object, as described in Section 6.1. of [@!OIDC]
7. SHALL require the `request_uri` parameter as defined in Section 6 of [@!OIDC] in the authentication request;
8. SHALL require that `request_uri` has been generated by this OP in the endpoint Initiate Authorize and indicates the location of a JWT Request inside the Authentication Server.
9. SHALL support the initiate `/authorize` endpoint, as described in section [Initiate Authorization Request](#initi-auth-req) of this specification.
10. SHALL return signed ID Token. (JWS)
11. SHALL ignore additional parameters passed using the OAuth 2.0 request syntax in the `/authorize` endpoint, only the `client_id` param should be passed (will be used to identify the RP), the parameters for authorization should be passed previously inside request_object in initiate authorize endpoint. This statement contradict section 6.1. of [@!OIDC]
12. SHALL validate `openid` value is present in scopes in all authorization requests.
13. SHALL generate and include the `txn` claim in all the generated `id_tokens` and claim responses (user info) to maintain a audit trail and traceability for all the Open ID process. (From beginning to end of the transaction)

# Error Response {#err-resp}

When Authorization Server should return a error to the Client because of any reason, the returned structure for the Error Response will have the defined in section 5.2. of [@!OAuth2.0].

In case that the Error Response is returned in a direct communication between the OP and the RP, the error response parameters will be returned in the HTTP response body using the application/json media type with HTTP response code of 400 (unless specified otherwise). As described in Section 3.1.3.4. of [@!OIDC].

The following is a non-normative example Error Response for this case:

```
  HTTP/1.1 400 Bad Request
  Content-Type: application/json
  Cache-Control: no-store
  Pragma: no-cache

  {
   "error": "invalid_request",
   "error_description": "Unsupported response_type value"
  }
```
  
In case that the Error Response is returned in a redirection step (like Authentication Request) the error response parameters are added to the query component of the Redirection URI, unless a different Response Mode was specified. As described in Section 3.1.2.6. of [@!OIDC].

```
  HTTP/1.1 302 Found
  Location: https://rp.example.com/cb?
    error=invalid_request
    &error_description=Unsupported%20response_type%20value
```

# Authorization Server Metadata

If the authorization server implement the DTP profile, it SHOULD include the following OAuth/OpenID Provider Metadata parameter in discovery responses:

* `digital_trust_protocol_extension` : A boolean field with value _true_ to inform the RP this OP implement this profile.

# Security Considerations {#security-considerations}

## Native Apps

For authorizing users in native apps the best practice described in RFC [@!OAuth.NativeApps] should be followed, for example the use of PKCE in the authorization flow.

## Client Authentication Methods {#client-auth-methods}

To enhance security implementations MUST only support and allow `private_key_jwt` as Client Authentication method, described in Section 9. of [@!OIDC].

The reasons for this specification to do not allow other Client Authentication Methods are:

* `none`: is not an authentication method so is not allowed.
* `client_secret_basic` and `client_secret_post` send over the network the complete credential that can be intercepted.
* `client_secret_jwt` is based on a shared secret and is a less secure version of the `private_key_jwt`.
* `tls_client_auth` and `self_signed_tls_client_auth` described in specification [@!OAuth.MTLS], are discarded because bind Network and Authentication layer.

During Client Registration, the RP (Client) MUST register a Client Authentication method. If no method is registered, the default method is `private_key_jwt`.

The supported Client Authentication Methods MAY be expanded if in the future if other method is provided by other implementers that commit with the security level provided by this specification.

The next is a non normative example of a jwt bearer following the specification of private_key_jwt method: (line wraps within JWS for display purposes only)

```
eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6InJwX3NlY19rZXkifQ.eyJpc3MiOiIzZGZkODllMS05NjRiLTRhYzQtY
mE0Ni05NzdmYzVmODdkYjkiLCJhdWQiOiJodHRwczovL29wLmV4YW1wbGUub3JnLyIsInN1YiI6IjNkZmQ4OWUxLTk2NGItNGFjN
C1iYTQ2LTk3N2ZjNWY4N2RiOSIsImlhdCI6MTU3MDAyMjU3NiwibmJmIjoxNTcwMDIyNTc2LCJleHAiOjE1NzAwMjI2MzYsImp0a
SI6IjcwMzNhMDVlLWQyOGEtNGMwMi04ZTZiLWUzZDI2YzRjZTk5MyJ9.N_sUjuLY9CrGFSLIiow-2I6zqtdCPUMt31St9rQCK9nD
mglkyyCj3ZJvvxjNE-c6H6wK7mEbL5d1StP1dhK7iARAkDH-7Jm-CxmcnmvbiqINkVjjkzrww3BMfwa87MPXga7C8-5u8VXokbfi
CflqFKbQFbKK7MjCz34loM6Mj6fHkV4HYNVDzAZv7zPKqjk-WRDJtVRjB2ON0ibVjEL-iNdZQLyN7nm8rto3xB7af5wfTJuvsXII
C1G--vHUZ6A9IxP84fR636IxSSUo8Y76Bp4ShmfqeD0jvTner1U2j77B_X01_3gbLAk6Gz48CPfZsDC6c6jW56mt99YZvjf5DQ
```

## Initiate authorize endpoint phishing 
In this attack, the RP developer is social engineered into believing that the initiate authorize endpoint has been changed to a URL that is controlled by the attacker. As the result, the client could send sensitive details to a rogue OP and the attacker will get hold of sensitive data.

This can be partially  mitigated by having the RP to enquiry the value of the above endpoint by calling the well known configuration endpoint. Alternatively, JWE could be used when sending requests.

## Token endpoint phishing 
In this attack, the RP developer is social engineered into believing that the token endpoint has been changed to a URL that is controlled by the attacker. As the result, the client could send an authorization code and a valid credential to a rogue OP. The attacked could then use them to retrieve the token from the honest OP.

This can be partially  mitigated by having the RP to enquiry the value of the above endpoint by calling the well known configuration endpoint. Alternatively, token can be returned encrypted as JWE.

Mutual TLS will prevent this attack, since the token endpoint cannot be called without a valid client certificate.

## Cryptographic Considerations

### TLS considerations
The minimum version of TLS MUST be v1.2.

Use only ciphersuites that ensure perfect forward secrecy (PFS) and authenticated encryption with associated data (AEAD). Therefore, encryption should be either AES with GCM or CHACHA20 with POLY1305, while key exchange and authentication SHOULD be part of ECDHE_RSA, ECDHE_ECDSA, DHE_RSA, DHE_DSS, CECPQ1 (together with all TLS 1.3 ciphers).

Examples of valid ciphers:
```
TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305
```

### JWS signing algorithms considerations

The following alghorithms SHALL NOT be allowd:
 * _none:_ It does not provide any form of authenticity nor integrity
 * _hmac:_ It does relies on the knowledge of a pre-shared key between OP and RP

It is reccomended to 
1.  Not use PKCS #1 v1.5 (RS256, RS384, RS512)
2.  Use PS256, ES256 or better


# Data Examples

The following sections show examples about request and responses that are used in the protocol flow.

## Authorize redirect response {#auth-redirect-resp}

The following is a non-normative example of a response from RP to the customer to start the authentication process. This redirect follow the Section 3.1.2.1 of [@!OIDC]

```
HTTP/1.1 302 Found
Location: https://op.example.com/authorize
    ?client_id=3dfd89e1-964b-4ac4-ba46-977fc5f87db9
    &request_uri=urn:example:Y7AyOKAK
```

Note that since we are using [@!OAuth.PAR] client_id param can be omitted and used inside the request object.

## Authentication request {#auth-req}

The following is a non-normative example of an authentication request to the /authorize endpoint in OP. This request follow the specification defined inSection 3.1.2.1 of [@!OIDC]

This request is the result of the redirection response [Authorize redirect response](#auth-redirect-resp). As explained in the [Authorize redirect response](#auth-redirect-resp) example client_id param can be omitted here.

```
GET /authorize
  ?client_id=3dfd89e1-964b-4ac4-ba46-977fc5f87db9
  &request_uri=urn:example:Y7AyOKAK

Host: op.example.com
```

## Successful Authorize response {#succ-auth-resp}

The following is a non-normative example of a response from OP when the customer Authenticates and consent to share the information. This response follow the specification described in Section 3.1.2.5. of [@!OIDC]

```
HTTP/1.1 302 Found
Location: https://rp.example.com/cb
    ?code=SplxlOBeZQQYbYS6WxSbIA
    &state=af0ifjsldkj
```

## Callback RP request {#callback-req}

The following is a non-normative example of a request to the callback RP endpoint containing the code and state. 

```
GET /cb
    ?code=SplxlOBeZQQYbYS6WxSbIA
    &state=af0ifjsldkj

Host: rp.example.com
```

## Token request {#token-req}

The following is a non-normative example of a Token Request following the specification described described in the section 3.1.3.1. of [@!OIDC].

The Client MUST be authenticated to the Token Endpoint using the authentication method registered for its client_id, as described in Section [Client Authentication Methods](#client-auth-methods).

```
POST /token HTTP/1.1
Host: op.example.com
Content-Type: application/x-www-form-urlencoded
 ?grant_type=authorization_code
 &code=SplxlOBeZQQYbYS6WxSbIA
 &redirect_uri=https://rp.example.org/cb
 &client_assertion_type=urn%3Aietf%3Aparams%3Aoauth%3Aclient-assertion-type%3Ajwt-bearer
 &client_assertion=eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6InJwX3NlY19rZXkifQ.eyJpc3MiOiIzZGZkODllMS05NjRiL
TRhYzQtYmE0Ni05NzdmYzVmODdkYjkiLCJhdWQiOiJodHRwczovL29wLmV4YW1wbGUub3JnLyIsInN1YiI6IjNkZmQ4OWUxLTk2NGItNGFjNC1i
YTQ2LTk3N2ZjNWY4N2RiOSIsImlhdCI6MTU3MDAyMjU3NiwibmJmIjoxNTcwMDIyNTc2LCJleHAiOjE1NzAwMjI2MzYsImp0aSI6IjcwMzNhMDV
lLWQyOGEtNGMwMi04ZTZiLWUzZDI2YzRjZTk5MyJ9.N_sUjuLY9CrGFSLIiow-2I6zqtdCPUMt31St9rQCK9nDmglkyyCj3ZJvvxjNE-c6H6wK7
mEbL5d1StP1dhK7iARAkDH-7Jm-CxmcnmvbiqINkVjjkzrww3BMfwa87MPXga7C8-5u8VXokbfiCflqFKbQFbKK7MjCz34loM6Mj6fHkV4HYNVD
zAZv7zPKqjk-WRDJtVRjB2ON0ibVjEL-iNdZQLyN7nm8rto3xB7af5wfTJuvsXIIC1G--vHUZ6A9IxP84fR636IxSSUo8Y76Bp4ShmfqeD0jvTn
er1U2j77B_X01_3gbLAk6Gz48CPfZsDC6c6jW56mt99YZvjf5DQ
```

## Token response {#token-resp}

The following is a non-normative example of a token response following the specifications of described in Section 3.1.3.3. of [@!OIDC].

The id_token parameter is explained in section [ID token example](#id-token-example) (with line wraps within values for display purposes only)

```
HTTP/1.1 200 OK
  Content-Type: application/json
  Cache-Control: no-store
  Pragma: no-cache

  {
   "access_token": "SlAV32hkKG",
   "token_type": "Bearer",
   "refresh_token": "8xLOxBtZp8",
   "expires_in": 3600,
   "id_token": "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6Im9wX2tleV8xIn0.eyJpc3MiOiJodHRwczovL29wLmV4YW1wbGUub
3JnLyIsImF1ZCI6Imh0dHBzOi8vcnAuZXhhbXBsZS5jb20iLCJzdWIiOiIxNDI1MzY3NDgiLCJub25jZSI6Im4tMDEwX00xNlUzMSIsImF0X2hhc2
giOiJ6MGNZbk9OQmM5VGRoZ1JVZGxKM0RPNkFyTDJNLXZfNzBpUGo5bG5BbG5RIiwiZ2l2ZW5fbmFtZSI6IkphbmUiLCJmYW1pbHlfbmFtZSI6IkR
vZSIsImJpcnRoZGF0ZSI6IjE5OTAtMDEtMzAiLCJjZXJ0aWZpZWRfY2xhaW1zIjp7ImNlcnRpZmllZF9naXZlbl9uYW1lIjp7InZhbHVlIjoiSmFu
ZSIsImVudGl0eSI6IlNhbnRhbmRlciIsImxvYSI6M30sImNlcnRpZmllZF9mYW1pbHlfbmFtZSI6eyJ2YWx1ZSI6IkRvZSIsImVudGl0eSI6IlNhb
nRhbmRlciIsImxvYSI6M30sImNlcnRpZmllZF9uYXRpb25hbGl0eSI6eyJ2YWx1ZSI6IkJyaXRpc2giLCJlbnRpdHkiOiJTYW50YW5kZXIiLCJsb2
EiOjN9LCJjZXJ0aWZpZWRfYmlydGhkYXRlIjp7InZhbHVlIjoiMTk5MC0wMS0zMCIsImVudGl0eSI6IlNhbnRhbmRlciIsImxvYSI6M319LCJpYXQ
iOjE1NjgzNzk4ODQsImV4cCI6MTU2ODM3OTk0NH0.chwTi-Pt9A7t2O1WvAGQzxNBIoQKbxlDThLa946hgNvtMlbPuIdnMfsbxDBZb-paF0JdEXyhHNQvX9AqqZ7j9rfOJrMYqSawmUJCyjO9IppSuucZ3eVcHPzcSuOCdWQl0GQ8rBtFZJbTbX4SP5oavLLb-hZgC-F86Gt-_jAE6sT-zXAR9zsQ4IASNjGJHAbpD36NTK6HC4TsOa77b8cJtYKbwqqBqFDcnyi1uwOusbdg_zI6M5wRpMWIF0LQBiLVnYX-n4gAwWyeGuB4_7iMLfSvIsL0hzaq7pMsRqikHnIceBSfklaEnWyiRdhf0tPNajIaho6pLKAXdWnrCk7DWw"
  }
```

## JWS request object

The following is a non-normative example of an authorization request JWT, this example follow the specification described in Section 6. of [@!OIDC].

The request object contain the requested claims inside the payload as described in section 5.5. of [@!OIDC], apart from using scopes as templates this is the preferred way to request claims instead scope directly. Additional JWT object MUST contain the next claims:

* nbf: The time before which the signed authentication request is unacceptable
* jti: A unique identifier for the signed authentication request.

The reason for this two claims is to avoid an attacker in control to the clock on the client to generate long lived JWT Authentication request.

```json
{
   "iss": "3dfd89e1-964b-4ac4-ba46-977fc5f87db9",
   "aud": "https://op.example.com",
   "response_type": "code",
   "client_id": "3dfd89e1-964b-4ac4-ba46-977fc5f87db9",
   "redirect_uri": "https://rp.example.org/cb",
   "scope": "openid",
   "state": "af0ifjsldkj",
   "nonce": "n-010_M16U31",
   "claims":
    {
     "id_token":
      {
        "given_name": {"essential": true},
        "family_name": {"essential": true},
        "passport_number": null,
        "nationality": null,
        "birthdate": {"essential": true},
        "place_of_birth": null
      }
    }
}
```

Signing it with the RS512 algorithm results in this Request Object value [@!JWS], this value is used in the request [Authentication request](#auth-req).

 (line wraps within values for display purposes only)
```
eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6InJwX2tleV8yIn0.eyJpc3MiOiIzZGZkODllMS05NjRiLTRhYzQtYmE0Ni05NzdmYzVmODdk
YjkiLCJhdWQiOiJodHRwczovL29wLmV4YW1wbGUuY29tIiwicmVzcG9uc2VfdHlwZSI6ImNvZGUiLCJjbGllbnRfaWQiOiIzZGZkODllMS05NjRiLTRh
YzQtYmE0Ni05NzdmYzVmODdkYjkiLCJyZWRpcmVjdF91cmkiOiJodHRwczovL3JwLmV4YW1wbGUub3JnL2NiIiwic2NvcGUiOiJvcGVuaWQiLCJzdGF0
ZSI6ImFmMGlmanNsZGtqIiwibm9uY2UiOiJuLTAxMF9NMTZVMzEiLCJjbGFpbXMiOnsiaWRfdG9rZW4iOnsiZ2l2ZW5fbmFtZSI6eyJlc3NlbnRpYWwi
OnRydWV9LCJmYW1pbHlfbmFtZSI6eyJlc3NlbnRpYWwiOnRydWV9LCJwYXNzcG9ydF9udW1iZXIiOm51bGwsIm5hdGlvbmFsaXR5IjpudWxsLCJiaXJ0
aGRhdGUiOnsiZXNzZW50aWFsIjp0cnVlfSwicGxhY2Vfb2ZfYmlydGgiOm51bGx9fSwiaWF0IjoxNTY4NzI0OTQ5LCJuYmYiOjE1Njg3MjQ5NDksImV4
cCI6MTU2ODcyNTAwOSwianRpIjoiYTMyNGM5YWMtYTQ3Yy00MWE4LWFkM2ItMDY5M2IxODE3ZGM5In0.EojFJ5r_FgDGcQS9kjKgwgs759DN6MlS9di_
LCnwN2le0PFo51fVYKLwupIfnCduY_i2iPgVuCMlx9UM5WV9FdogDf-r1BoF-cp9FLCCd8x-C9VIXKHTXO5jkQ-6jiOG1X00gK7s9-zL7DGlFjXYy8FKiyB1ByZ3onEI4IFFCnJyq3PuTK6UqIYVOOsQ_JgkQvtSdRFVF3jQUzT5bcZb8vGhLL8LGRktfa7CtI-6iHkZzRvcyQvB65hT3yUsC7qxA8UHazHN4n8jIh_vjoMmopMNhFnRzUdEQyuF5l25uJkr5gYbzcrzJPA0byTp4h186muiAxQKWookHSIUNO-ubQ
```

This JWS can be validated using the [Example Keys](#example-keys)

## ID token example {#id-token-example}

The following is a non-normative example of an id token returned by the OP following the specifications described in Section 2. of [@!OIDC].

```json
{
   "iss": "https://op.example.org/",
   "aud": "3dfd89e1-964b-4ac4-ba46-977fc5f87db9",
   "sub": "142536748",
   "txn": "V1StGXR8_Z5jdHi6B-myT",
   "nonce": "n-010_M16U31",
   "at_hash":"z0cYnONBc9TdhgRUdlJ3DO6ArL2M-v_70iPj9lnAlnQ",
   "given_name": "Jane",
   "family_name" : "Doe",
   "birthdate": "1990-01-30"
}
```

After signing the JWT and add the mandatory claims we obtain the next [@!JWS]. (line wraps within values for display purposes only)

```
eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6Im9wX2tleV8xIn0.eyJpc3MiOiJodHRwczovL29wLmV4YW1wbGUub3JnLyIsIm
F1ZCI6IjNkZmQ4OWUxLTk2NGItNGFjNC1iYTQ2LTk3N2ZjNWY4N2RiOSIsInN1YiI6IjE0MjUzNjc0OCIsIm5vbmNlIjoibi0wMTBfTTE2
VTMxIiwiYXRfaGFzaCI6InowY1luT05CYzlUZGhnUlVkbEozRE82QXJMMk0tdl83MGlQajlsbkFsblEiLCJnaXZlbl9uYW1lIjoiSmFuZS
IsImZhbWlseV9uYW1lIjoiRG9lIiwiYmlydGhkYXRlIjoiMTk5MC0wMS0zMCIsImNlcnRpZmllZF9jbGFpbXMiOnsiY2VydGlmaWVkX2dp
dmVuX25hbWUiOnsidmFsdWUiOiJKYW5lIiwiZW50aXR5IjoiU2FudGFuZGVyIiwibG9hIjozfSwiY2VydGlmaWVkX2ZhbWlseV9uYW1lIj
p7InZhbHVlIjoiRG9lIiwiZW50aXR5IjoiU2FudGFuZGVyIiwibG9hIjozfSwiY2VydGlmaWVkX25hdGlvbmFsaXR5Ijp7InZhbHVlIjoi
QnJpdGlzaCIsImVudGl0eSI6IlNhbnRhbmRlciIsImxvYSI6M30sImNlcnRpZmllZF9iaXJ0aGRhdGUiOnsidmFsdWUiOiIxOTkwLTAxLT
MwIiwiZW50aXR5IjoiU2FudGFuZGVyIiwibG9hIjozfX0sImlhdCI6MTU2ODc5NTI4NywibmJmIjoxNTY4Nzk1Mjg3LCJleHAiOjE1Njg3
OTUzNDcsImp0aSI6ImY5MTdkMDcxLTE4NDItNGRkOC1iODZmLTJhN2YwNDIzYzdhMiJ9.d2GDd1Qm_xnb9-Vg12oE3xzgp_Qn4hTEM-gcZ
EL5kohM44E5JKZbSpgmnKAQMn-fYDl1y5kExaNbruzzu2F2Rsk976YJxKd_R8Wg67FhMFqbOGn71vGRGxT47LhXdCVy1_H0ptoJ8K8hJW3
3HOrMHoaSQjoKcoBrkzlJSmqAB60zVKo3nGnEhzz8osnWOP9xoRsc0zeM_On9iFhPpELjm-iLUy0tW9u7sGqQOpJLhKfh_721m_i4G1n9lDnQCs9qnjTbJ0ESV4lxLVAZ2ACoWtnCbtvvGEgtMiQMwCd8_RdVvNZIKGbXTinA20x7FXvK
3AttXH901JkMzwRiG-RUPQ
```

## Example Keys {#example-keys}

The next keys are just for illustrative purposes, should only be used to generate the examples in this documentation.

All the sample jws showed in this page have been signed using these keys using the same for RP and OP jwts, in a real implementation each actor in the protocol has his own key pairs.

### Public KEY {#public-key}

```
\-----BEGIN CERTIFICATE-----
MIIDtTCCAp2gAwIBAgIJAMKR/NsyfcazMA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEwHwYDVQQKExhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwHhcNMTIxMTEyMjM0MzQxWhcNMTYxMjIxMjM0MzQxWjBF
MQswCQYDVQQGEwJBVTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8GA1UEChMYSW50
ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAvtH4wKLYlIXZlfYQFJtXZVC3fD8XMarzwvb/fHUyJ6NvNStN+H7GHp3/
QhZbSaRyqK5hu5xXtFLgnI0QG8oE1NlXbczjH45LeHWhPIdc2uHSpzXic78kOugM
Y1vng4J10PF6+T2FNaiv0iXeIQq9xbwwPYpflViQyJnzGCIZ7VGan6GbRKzyTKcB
58yx24pJq+CviLXEY52TIW1l5imcjGvLtlCp1za9qBZa4XGoVqHi1kRXkdDSHty6
lZWj3KxoRvTbiaBCH+75U7rifS6fR9lqjWE57bCGoz7+BBu9YmPKtI1KkyHFqWpx
aJc/AKf9xgg+UumeqVcirUmAsHJrMwIDAQABo4GnMIGkMB0GA1UdDgQWBBTs83nk
LtoXFlmBUts3EIxcVvkvcjB1BgNVHSMEbjBsgBTs83nkLtoXFlmBUts3EIxcVvkv
cqFJpEcwRTELMAkGA1UEBhMCQVUxEzARBgNVBAgTClNvbWUtU3RhdGUxITAfBgNV
BAoTGEludGVybmV0IFdpZGdpdHMgUHR5IEx0ZIIJAMKR/NsyfcazMAwGA1UdEwQF
MAMBAf8wDQYJKoZIhvcNAQEFBQADggEBABw7w/5k4d5dVDgd/OOOmXdaaCIKvt7d
3ntlv1SSvAoKT8d8lt97Dm5RrmefBI13I2yivZg5bfTge4+vAV6VdLFdWeFp1b/F
OZkYUv6A8o5HW0OWQYVX26zIqBcG2Qrm3reiSl5BLvpj1WSpCsYvs5kaO4vFpMak
/ICgdZD+rxwxf8Vb/6fntKywWSLgwKH3mJ+Z0kRlpq1g1oieiOm1/gpZ35s0Yuor
XZba9ptfLCYSggg/qc3d3d0tbHplKYkwFm7f5ORGHDSD5SJm+gI7RPE+4bO8q79R
PAfbG1UGuJ0b/oigagciHhJp851SQRYf3JuNSc17BnK2L5IEtzjqr+Q=
-----END CERTIFICATE-----
```

### Private KEY {#private-key}

```
\-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAvtH4wKLYlIXZlfYQFJtXZVC3fD8XMarzwvb/fHUyJ6NvNStN
+H7GHp3/QhZbSaRyqK5hu5xXtFLgnI0QG8oE1NlXbczjH45LeHWhPIdc2uHSpzXi
c78kOugMY1vng4J10PF6+T2FNaiv0iXeIQq9xbwwPYpflViQyJnzGCIZ7VGan6Gb
RKzyTKcB58yx24pJq+CviLXEY52TIW1l5imcjGvLtlCp1za9qBZa4XGoVqHi1kRX
kdDSHty6lZWj3KxoRvTbiaBCH+75U7rifS6fR9lqjWE57bCGoz7+BBu9YmPKtI1K
kyHFqWpxaJc/AKf9xgg+UumeqVcirUmAsHJrMwIDAQABAoIBAQCYKw05YSNhXVPk
eHLeW/pXuwR3OkCexPrakOmwMC0s2vIF7mChN0d6hvhVlUp68X7V8SnS2JxAGo8v
iHY+Et3DdwZ3cxnzwh+BEhzgDfoIOmkoGppZPyX/K6klWtbGUrTtSISOWXbvEXQU
G0qGAvDOzIGTsdMDX7slnU70Ac23JybPY5qBSiE+ky8U4dm2fUHMroWub4QP5vA/
nqyWqX2FB/MEAbcujaknDQrFCtbmtUYlBbJCKGd9V3cGEqp6H7oH+ah2ofMc91gJ
mCHk3YyWZB/bcVXH3CA+s1ywvCOVDBZ3Nw7Pt9zIcv6Rl9UKIy+Nx0QjXxR90Hla
Tr0GHIShAoGBAPsD7uXm+0ksnGyKRYgvlVad8Z8FUFT6bf4B+vboDbx40FO8O/5V
PraBPC5z8YRSBOQ/WfccPQzakkA28F2pXlRpXu5JcErVWnyyUiKpX5sw6iPenQR2
JO9hY/GFbKiwUhVHpvWMcXFqFLSQu2A86jPnFFEfG48ZT4IhTzINKJVZAoGBAMKc
B3YGfVfY9qiRFXzYRdSRLg5c8p/HzuWwXc9vfJ4kQTDkPXe/+nqD67rzeT54uVec
jKoIrsCu4BfEaoyvOT+1KmUfdEpBgYZuuEC4CZf7dgKbXOpPVvZDMyJ/e7HyqTpw
mvIYJLPm2fNAcAsnbrNX5mhLwwzEIltbplUUeRdrAoGBAKhZgPYsLkhrZRXevreR
wkTvdUfD1pbHxtFfHqROCjhnhsFCM7JmFcNtdaFqHYczQxiZ7IqxI7jlNsVek2Md
3qgaa5LBKlDmOuP67N9WXUrGSaJ5ATIm0qrB1Lf9VlzktIiVH8L7yHHaRby8fQ8U
i7b3ukaV6HPW895A3M6iyJ8xAoGAInp4S+3MaTL0SFsj/nFmtcle6oaHKc3BlyoP
BMBQyMfNkPbu+PdXTjtvGTknouzKkX4X4cwWAec5ppxS8EffEa1sLGxNMxa19vZI
yJaShI21k7Ko3I5f7tNrDNKfPKCsYMEwgnHKluDwfktNTnyW/Uk2dgXuMaXSHHN5
XZt59K8CgYArGVOWK7LUmf3dkTIs3tXBm4/IMtUZmWmcP9C8Xe/Dg/IdQhK5CIx4
VXl8rgZNeX/5/4nJ8Q3LrdLau1Iz620trNRGU6sGMs3x4WQbSq93RRbFzfG1oK74
IOo5yIBxImQOSk5jz31gF9RJb15SDBIxonuWv8qAERyUfvrmEwR0kg==
-----END RSA PRIVATE KEY-----
```

# Acknowledgements {#acknowledgements}
The authors would like to acknowledge James Begg, Roderick Boothby, Desislava Ilieva and Ildefonso Olmedo for their vital support and feedback.

{backmatter}

<reference anchor="OAuth2.0" target="https://tools.ietf.org/html/rfc6749">
  <front>
    <title>The OAuth 2.0 Authorization Framework</title>
    <author initials="C." surname="Hardt" fullname="Dick Hardt">
      <organization>Microsoft</organization>
    </author>
   <date month="October" year="2012"/>
  </front>
</reference>

<reference anchor="OAuth.Multiple.Responses" target="https://openid.net/specs/oauth-v2-multiple-response-types-1_0.html">
  <front>
    <title>OAuth 2.0 Multiple Response Type Encoding Practices</title>
    <author initials="B." surname="de Medeiros" fullname="Breno de Medeiros">
      <organization>Google</organization>
    </author>
    <author initials="M." surname="Scurtescu" fullname="Marius Scurtescu">
      <organization>Google</organization>
    </author>
    <author initials="P." surname="Tarjan" fullname="Paul Tarjan">
      <organization>Facebook</organization>
    </author>
    <author initials="M." surname="B. Jones" fullname="Michael B. Jones">
      <organization>Microsoft</organization>
    </author>
   <date day="25" month="February" year="2014"/>
  </front>
</reference>

<reference anchor="OIDC" target="http://openid.net/specs/openid-connect-core-1_0.html">
  <front>
    <title>OpenID Connect Core 1.0 incorporating errata set 1</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
    <author initials="M." surname="Jones" fullname="Mike Jones">
      <organization>Microsoft</organization>
    </author>
    <author initials="B." surname="de Medeiros" fullname="Breno de Medeiros">
      <organization>Google</organization>
    </author>
    <author initials="C." surname="Mortimore" fullname="Chuck Mortimore">
      <organization>Salesforce</organization>
    </author>
   <date day="8" month="Nov" year="2014"/>
  </front>
</reference>

<reference anchor="JWT" target="https://tools.ietf.org/html/rfc7519">
  <front>
    <title>JSON Web Token (JWT)</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="M." surname="Jones" fullname="Mike Jones">
      <organization>Microsoft</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
   <date month="May" year="2015"/>
  </front>
</reference>

<reference anchor="JWS" target="https://tools.ietf.org/html/rfc7515">
  <front>
    <title>JSON Web Signature (JWS)</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="M." surname="Jones" fullname="Mike Jones">
      <organization>Microsoft</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
   <date month="May" year="2015"/>
  </front>
</reference>

<reference anchor="RFC2616" target="https://tools.ietf.org/html/rfc2616">
  <front>
    <title>Hypertext Transfer Protocol -- HTTP/1.1</title>
    <author initials="R." surname="Fielding" fullname="Roy T. Fielding">
      <organization>UC Irvine</organization>
    </author>
   <date month="June" year="1999"/>
  </front>
</reference>

<reference anchor="RFC2119" target="https://tools.ietf.org/html/rfc2119">
  <front>
    <title>Key words for use in RFCs to Indicate Requirement Levels</title>
    <author initials="S." surname="Bradner" fullname="Scott Bradner">
      <organization>Harvard University</organization>
    </author>
   <date month="March" year="1997"/>
  </front>
</reference>

<reference anchor="OAuth.PAR" target="https://tools.ietf.org/html/draft-lodderstedt-oauth-par-01">
  <front>
    <title>OAuth 2.0 Pushed Authorization Requests draft-lodderstedt-oauth-par-01</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="T." surname="Lodderstedt" fullname="Torsten Lodderstedt">
      <organization>yes.com</organization>
    </author>
    <author initials="B." surname="Campbell" fullname="Brian Campbell">
      <organization>Ping Identity</organization>
    </author>
    <author initials="D." surname="Tonge" fullname="Dave Tonge">
      <organization>Moneyhub Financial Technology</organization>
    </author>
    <author initials="F." surname="Skokan" fullname="Filip Skokan">
      <organization>Auth0</organization>
    </author>
   <date day="2" month="November" year="2019"/>
  </front>
</reference>

<reference anchor="URN" target="https://tools.ietf.org/html/rfc2141">
  <front>
    <title>Uniform Resource Names</title>
    <author initials="R." surname="Moats" fullname="Ryan Moats">
      <organization><![CDATA[AT&T]]></organization>
    </author>
   <date month="May" year="1997"/>
  </front>
</reference>

<reference anchor="RFC8417" target="https://www.rfc-editor.org/info/rfc8417">
  <front>
    <title>Security Event Token (SET)</title>
    <author initials="P." surname="Hunt, Ed." fullname="Phil Hunt">
      <organization>Oracle</organization>
    </author>
    <author initials="M." surname="Jones" fullname="Michael B. Jones">
      <organization>Microsoft</organization>
    </author>
    <author initials="W." surname="Denniss" fullname="William Denniss">
      <organization>Google</organization>
    </author>
    <author initials="M." surname="Ansari" fullname="Morteza Ansari">
      <organization>Cisco</organization>
    </author>
   <date month="July" year="2018"/>
  </front>
</reference>

<reference anchor="OAuth.NativeApps" target="https://tools.ietf.org/html/rfc8252">
  <front>
    <title>OAuth 2.0 for Native Apps</title>
    <author initials="W." surname="Denniss" fullname="William Denniss">
      <organization>Google</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
   <date month="October" year="2017"/>
  </front>
</reference>

<reference anchor="OAuth.MTLS" target="https://tools.ietf.org/id/draft-ietf-oauth-mtls-07.html">
  <front>
    <title>OAuth 2.0 Mutual TLS Client Authentication and Certificate Bound Access Tokens</title>
    <author initials="N." surname="Sakimura" fullname="Nat Sakimura">
      <organization>NRI</organization>
    </author>
    <author initials="T." surname="Lodderstedt" fullname="Torsten Lodderstedt">
      <organization>yes.com</organization>
    </author>
    <author initials="B." surname="Campbell" fullname="Brian Campbell">
      <organization>Ping Identity</organization>
    </author>
    <author initials="J." surname="Bradley" fullname="John Bradley">
      <organization>Ping Identity</organization>
    </author>
   <date month="January" year="2018"/>
  </front>
</reference>

# IANA Considerations

## Registry Contents

TBD...

*   txn: review if already exist.
*   errors: response parameter in PAR.
*   digital_trust_protocol_extension: for metadata.

# Notices

MIT License

Copyright (c) 2020 Grupo Santander

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

# Document History

[[ To be removed from the final specification ]]

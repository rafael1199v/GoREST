Feature: Obtener lista de posts

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataUserGenerator = read('classpath:utils/random-user-data-generator.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token
    * def req_headers = {Authorization: Token}

  Scenario: Obtener lista exitosamente
    Given path 'posts'
    When method get
    Then status 200
    And match response == "#array"

    * def children = $response[*]
    * def schema = {id: "#number", user_id: "#number", title: "#string",  body: "#string"}

    And match each children == schema

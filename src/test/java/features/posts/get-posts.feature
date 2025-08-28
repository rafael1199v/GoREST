Feature: Obtener lista de posts

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  @ListResources @Regression
  Scenario: Obtener lista exitosamente
    Given path 'posts'
    When method get
    Then status 200
    And match response == "#array"

    * def children = $response[*]
    * def schema = {id: "#number", user_id: "#number", title: "#string",  body: "#string"}

    And match each children == schema

Feature: Listar usuarios

  Background:
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataGenerator = read('classpath:utils/random-user-data-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  @ListResources @Regression
  Scenario: Listar los usuarios de manera exitosa
    Given path 'users'
    When method get
    Then status 200
    And match response == "#array"

    * def children = $response[*]
    * def schema =
    """
    {
      "id": "#number",
      "name": "#string",
      "email": "#string",
      "gender": "#string",
      "status": "#string"
    }
    """
    And match each children == schema


  Scenario: Listar a un usuario en especifico
    * def email = randomDataGenerator().generateRandomEmail()

    Given path 'users'
    And request
    """
    {
      "name": "Rafael",
      "email": "#(email)",
      "gender": "male",
      "status": "active"
    }
    """
    When method post
    Then status 201

    * def userId = response.id

    Given path 'users', userId
    And header Authorization = getBearerToken()
    When method get
    Then status 200
    And match response.id == userId

  @Regression
  Scenario: Tiempo de respuesta en menos de 15000ms
    Given path 'users'
    When method get
    Then status 200
    And assert responseTime < 15000

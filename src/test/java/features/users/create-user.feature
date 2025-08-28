@PostResource
Feature: Crear un usuario

  Background:
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataGenerator = read('classpath:utils/random-user-data-generator.js')
    * url baseUrl
    * header Authorization = getBearerToken()

  Scenario: Usuario creado exitosamente
    * def email = randomDataGenerator().generateRandomEmail()
    * def name = randomDataGenerator().generateRandomName()
    * def gender = randomDataGenerator().generateRandomGender()
    * def status = randomDataGenerator().generateRandomStatus()

    * def newUser =
    """
    {
      "name": "#(name)",
      "gender": "#(gender)",
      "email": "#(email)",
      "status": "#(status)"
    }
    """

    Given path 'users'
    And request newUser
    When method post
    Then status 201
    And match response ==
      """
      {
        "id": "#number",
        "name": "#(name)",
        "gender": "#(gender)",
        "email": "#(email)",
        "status": "#(status)"
      }
      """
    And assert responseTime < 15000


  Scenario: Crear usuario con un cuerpo vacio
    Given path 'users'
    And request ''
    When method post
    Then status 422
    And match response == "#array"

    * def children = $response[*]
    * def schema = { "field": "#present", "message": "#present" }

    And match each children == schema

  Scenario: Crear un usuario con un email invalido
    Given path 'users'
    And request
    """
    {
      "name": "Rafael",
      "gender": "male",
      "email": "InvalidEmail",
      "status": "active"
    }
    """
    When method post
    Then status 422

    * def responseError = response[0]

    And match responseError ==
    """
    {
      "field": "#string",
      "message": "#string"
    }
    """
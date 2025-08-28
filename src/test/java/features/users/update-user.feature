@UpdateResource
Feature: Actualizar un usuario

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataGenerator = read('classpath:utils/random-user-data-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Actualizar un usuario correctamente
    * def userId = data.response.id
    * def email = randomDataGenerator().generateRandomEmail()
    * def name = randomDataGenerator().generateRandomName()
    * def status = randomDataGenerator().generateRandomStatus()

    Given path 'users', data.response.id
    And request
    """
    {
      "name": "#(name)",
      "email": "#(email)",
      "status": "#(status)"
    }
    """
    When method patch
    Then status 200
    And match response ==
    """
    {
      "email": "#(email)",
      "name": "#(name)",
      "status": "#(status)",
      "id": "#(userId)",
      "gender": "#string"
    }
    """

  @NotFound
  Scenario:  Actualizar un usuario inexistente
    * def email = randomDataGenerator().generateRandomEmail()
    * def name = randomDataGenerator().generateRandomName()
    * def status = randomDataGenerator().generateRandomStatus()

    Given path 'users', '-1'
    And request
    """
    {
      "name": "#(name)",
      "email": "#(email)",
      "status": "#(status)"
    }
    """
    When method patch
    Then status 404
    And match response.message == "Resource not found"


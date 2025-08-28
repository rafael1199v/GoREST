@DeleteResource
Feature: Eliminar a un usuario

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataGenerator = read('classpath:utils/random-user-data-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Eliminar a un usuario exitosamente
    * def userId = data.response.id

    Given path 'users', userId
    When method delete
    Then status 204
    And assert responseTime < 15000
    And match response == ""

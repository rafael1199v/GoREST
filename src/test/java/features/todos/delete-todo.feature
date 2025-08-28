@DeleteResource
Feature: Eliminar una tarea

  Background:
    * def data = callonce read("classpath:helpers/create-todo.feature")
    * def todo = data.response
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Eliminar una tarea existente
    Given path 'todos', todo.id
    When method delete
    Then status 204
    And match response == ""
    And assert responseTime < 15000

  @NotFound
  Scenario: Eliminar una tarea no existente
    Given path 'todos', '-1'
    When method delete
    Then status 404
    And match response.message == "Resource not found"
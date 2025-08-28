@DeleteResource
Feature: Eliminar un post

  Background:
    * def data = callonce read("classpath:helpers/create-post.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Eliminar un post exitosamente
    * def postId = data.response.id

    Given path 'posts', postId
    When method delete
    Then status 204
    And match response == ""
    And assert responseTime < 15000
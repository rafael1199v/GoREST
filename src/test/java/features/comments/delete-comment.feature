Feature: Eliminar un comentario

  Background:
    * def data = call read("classpath:helpers/create-comment.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token
    * def commentId = data.response.id

  Scenario: Eliminar un comentario exitosamente
    Given path 'comments', commentId
    When method delete
    Then status 204
    And match response == ""
    And assert responseTime < 3000
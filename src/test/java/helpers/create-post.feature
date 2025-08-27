Feature: Crear un post

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataUserGenerator = read('classpath:utils/random-user-data-generator.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token
    * def req_headers = {Authorization: Token}

  Scenario: Crear post exitosamente
    * def userId = data.response.id
    * def title = randomDataTextGenerator().generateRandomTitle()
    * def body = randomDataTextGenerator().generateRandomBody()

    Given path 'users', userId, 'posts'
    And request
      """
      {
        "user": {
          "id": "#(userId)",
          "name": "#(data.response.name)",
          "email": "#(data.response.email)",
          "gender": "#(data.response.gender)",
          "status": "#(data.response.status)"
        },
        "title": "#(title)",
        "body": "#(body)"
      }
      """
    When method post
    Then status 201

Feature: Crear un comentario

  Background:
    * def data = callonce read("classpath:helpers/create-post.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token
    * def userId = data.response.user_id
    * def postId = data.response.id

  Scenario: Crear un comentario exitosamente
    Given path 'users', userId
    When method get
    Then status 200

    * def email = response.email
    * def name = response.name
    * def body = randomDataTextGenerator().generateRandomBody()

    Given path 'posts', postId, 'comments'
    And header Authorization = Token
    And request
    """
    {
      email: "#(email)",
      name: "#(name)",
      body: "#(body)"
    }
    """
    When method post
    Then status 201
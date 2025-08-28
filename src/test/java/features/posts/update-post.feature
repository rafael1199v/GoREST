@UpdateResource
Feature: Actualizar un posts

  Background:
    * def data = callonce read("classpath:helpers/create-post.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Actualizar un post correctamente
    * def postId = data.response.id
    * def userId = data.response.user_id
    * def newTitle = randomDataTextGenerator().generateRandomTitle()
    * def newBody = randomDataTextGenerator().generateRandomBody()

    Given path 'posts', postId
    And request
    """
    {
      title: "#(newTitle)",
      body: "#(newBody)"
    }
    """
    When method patch
    Then status 200
    And match response ==
    """
    {
      id: "#(postId)",
      user_id: "#(userId)",
      title: "#(newTitle)",
      body: "#(newBody)"
    }
    """
    And assert responseTime < 15000

  Scenario: Actualizar un post con un cuerpo vacio
    * def postId = data.response.id

    Given path 'posts', postId
    And request
    """
    {
      title: "newTitle",
      body: ""
    }
    """
    When method patch
    Then status 422
    Then match response[0] ==
    """
    {
      field: "body",
      message: "can't be blank"
    }
    """

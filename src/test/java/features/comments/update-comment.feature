Feature: Actualizar un comentario

  Background:
    * def data = call read("classpath:helpers/create-comment.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token
    * def commentId = data.response.id

  Scenario: Actualizar un comentario correctamente
    * def newBody = randomDataTextGenerator().generateRandomBody()

    Given path 'comments', commentId
    And request
    """
    {
      body: "#(newBody)"
    }
    """
    When method patch
    Then status 200
    And match response ==
    """
    {
      body: "#(newBody)",
      id: "#(commentId)",
      post_id: "#(data.response.post_id)",
      name: "#(data.response.name)",
      email: "#(data.response.email)"
    }
    """


  Scenario: Actualizar un comentario con el cuerpo de solicitud vacio
    Given path 'comments', commentId
    And request ""
    When method patch
    Then status 200
    And match response ==
    """
    {
      body: "#(data.response.body)",
      id: "#(commentId)",
      post_id: "#(data.response.post_id)",
      name: "#(data.response.name)",
      email: "#(data.response.email)"
    }
    """


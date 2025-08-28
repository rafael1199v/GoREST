Feature: Listar comentarios

  Background:
    * def data = callonce read("classpath:helpers/create-comment.feature")
    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  @ListResources @Regression
  Scenario: Listar comentarios de manera exitosa
    Given path 'comments'
    When method get
    Then status 200
    And match response == "#array"

    * def children = $response[*]
    * def schema = {id: "#number", post_id: "#number", name: "#string", email: "#string", body: "#string"}

    And match each children == schema

  Scenario: Listar un unico comentario correctamente
    * def commentId = data.response.id

    Given path 'comments', commentId
    When method get
    Then status 200
    And match response ==
    """
    {
      id: "#(commentId)",
      post_id: "#(data.response.post_id)",
      name: "#(data.response.name)",
      email: "#(data.response.email)",
      body: "#(data.response.body)"
    }
    """
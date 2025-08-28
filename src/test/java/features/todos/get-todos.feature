Feature: Listar tareas

  Background:
    * def statusList = ["completed", "pending"]
    * def timeList = ["2026-04-06T01:26:11.000+05:30", "2026-04-06T02:26:11.000+05:30"]

    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * def statusChecker = read('classpath:utils/check-array-value.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token


  @ListResources @Regression
  Scenario: Listar las tareas de manera exitosa
    Given path 'todos'
    When method get
    Then status 200

    * def children = $response[*]
    * def schema = {id: "#number", user_id: "#number", title: "#string", due_on: "#present", status: "#string"}

    And match each children == schema
    And assert statusChecker(statusList, children, "status") == true

  @NotFound
  Scenario: Listar una tarea inexistente
    * def todoId = -1

    Given path 'todos', todoId
    When method get
    Then status 404
    And match response.message == "Resource not found"

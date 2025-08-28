@PostResource
Feature: Crear una tarea

  Background:
    * def data = callonce read("classpath:helpers/create-user.feature")
    * def user = data.response

    * def statusList = ["completed", "pending"]
    * def timeList = ["2026-04-06T01:26:11.000+05:30", "2026-04-06T02:26:11.000+05:30"]

    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Crear una tarea de manera exitosa
    * def todoTitle = randomDataTextGenerator().generateRandomTitle()
    * def todoStatus = randomDataTextGenerator().chooseRandomItem(statusList)
    * def todoDueOn = randomDataTextGenerator().chooseRandomItem(timeList)

    Given path 'users', user.id, 'todos'
    And request
    """
    {
      title: "#(todoTitle)",
      status: "#(todoStatus)",
      due_on: "#(todoDueOn)",
    }
    """
    When method post
    Then status 201
    And match response ==
    """
    {
      id: "#number",
      user_id: "#(user.id)",
      title: "#(todoTitle)",
      due_on: "#(todoDueOn)",
      status: "#(todoStatus)"
    }
    """
  Scenario: Crear una tarea sin el campo "due_on"
    Given path 'users', user.id, 'todos'
    And request
    """
    {
      "title": "Title with no due_on",
      "status": "completed"
    }
    """
    When method post
    Then status 201
    And match response ==
    """
    {
      id: "#number",
      user_id: "#(user.id)",
      title: "#string",
      due_on: "#null",
      status: "#string"
    }
    """



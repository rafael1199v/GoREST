@UpdateResource
Feature: Actualizar una tarea

  Background:
    * def data = callonce read("classpath:helpers/create-todo.feature")
    * def todo = data.response

    * def statusList = ["completed", "pending"]
    * def timeList = ["2026-04-06T01:26:11.000+05:30", "2026-04-06T02:26:11.000+05:30"]

    * def getBearerToken = read('classpath:utils/authorize.js')
    * def randomDataTextGenerator = read('classpath:utils/random-text-generator.js')
    * url baseUrl
    * def Token = getBearerToken()
    * header Authorization = Token

  Scenario: Actualizar una tarea de manera exitosa
    * def newTitle = randomDataTextGenerator().generateRandomTitle()
    * def newStatus = randomDataTextGenerator().chooseRandomItem(statusList)

    Given path 'todos', todo.id
    And request
    """
    {
      title: "#(newTitle)",
      status: "#(newStatus)"
    }
    """
    When method patch
    Then status 200
    And match response ==
    """
    {
      id: "#(todo.id)",
      user_id: "#(todo.user_id)",
      title: "#(newTitle)",
      due_on: "#(todo.due_on)",
      status: "#(newStatus)"
    }
    """
    And assert (response.status == "completed" || response.status == "pending")
    And assert responseTime < 15000


  Scenario: Actualizar una tarea con un estado invalido
    Given path 'todos', todo.id
    And request
    """
    {
      title: "NewTitle",
      status: "No valid"
    }
    """
    When method patch
    Then status 422
    And match response[0] ==
    """
    {
      field: "status",
      message: "can't be blank, can be pending or completed"
    }
    """


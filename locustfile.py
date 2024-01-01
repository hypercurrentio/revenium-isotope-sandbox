from locust import HttpUser, task, between
import json

class ApiUser(HttpUser):
    wait_time = between(1, 2)

    @task
    def post_data(self):
        headers = {'content-type': 'application/json'}
        data = {"key1": "value1", "key2": "value2"}  # Customize this as per your API's requirements
        self.client.post("/echo", data=json.dumps(data), headers=headers)


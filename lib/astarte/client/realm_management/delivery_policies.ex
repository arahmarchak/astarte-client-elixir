#
# This file is part of Astarte.
#
# Copyright 2024 SECO Mind
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

defmodule Astarte.Client.RealmManagement.DeliveryPolicies do
  alias Astarte.Client.{APIError, RealmManagement}

  def list(%RealmManagement{} = client) do
    request_path = "policies"
    tesla_client = client.http_client

    with {:ok, %Tesla.Env{} = result} <- Tesla.get(tesla_client, request_path) do
      if result.status == 200 do
        {:ok, result.body}
      else
        {:error, %APIError{status: result.status, response: result.body}}
      end
    end
  end

  def get(%RealmManagement{} = client, policy_name) when is_binary(policy_name) do
    request_path = "policies/#{policy_name}"
    tesla_client = client.http_client

    with {:ok, %Tesla.Env{} = result} <- Tesla.get(tesla_client, request_path) do
      if result.status == 200 do
        {:ok, result.body}
      else
        {:error, %APIError{status: result.status, response: result.body}}
      end
    end
  end

  def create(%RealmManagement{} = client, data) do
    request_path = "policies"
    tesla_client = client.http_client

    with {:ok, %Tesla.Env{} = result} <- Tesla.post(tesla_client, request_path, %{data: data}) do
      if result.status == 201 do
        :ok
      else
        {:error, %APIError{status: result.status, response: result.body}}
      end
    end
  end

  def delete(%RealmManagement{} = client, policy_name) when is_binary(policy_name) do
    request_path = "policies/#{policy_name}"
    tesla_client = client.http_client

    with {:ok, %Tesla.Env{} = result} <- Tesla.delete(tesla_client, request_path) do
      if result.status == 204 do
        :ok
      else
        {:error, %APIError{status: result.status, response: result.body}}
      end
    end
  end
end

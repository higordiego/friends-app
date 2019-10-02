defmodule Mix.Tasks.Utils.AddFakeFriends do
  use Mix.Task
  alias NimbleCSV.RFC4180, as: CSVParse

  @shortdoc "Add fake friends on App"
  def run(_) do
    Faker.start()

    create_friends([], 5)
    |> CSVParse.dump_to_iodata()
    |> save_csv_file()
  end

  defp create_friends(list, count) when count <= 1 do
    list ++ [ramdon_list_friend()]
  end

  defp create_friends(list, count) do
    list ++ [ramdon_list_friend()] ++ create_friends(list, count - 1)
  end

  defp ramdon_list_friend do
    %{
      name: Faker.Name.PtBr.name(),
      email: Faker.Internet.email(),
      phone: Faker.Phone.EnUs.phone()
    }
    |> Map.values()
  end

  defp save_csv_file(data) do
    File.write!("#{File.cwd!()}/friends.csv", data, [:append])
  end
end

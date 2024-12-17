"use client";
import Image from "next/image";
import faucet from "../../public/assets/faucetBanner.svg";
import deployer from "../../public/assets/deployerBanner.svg";
import wikipedia from "../../public/assets/wikipediaBanner.svg";
import addressBook from "../../public/assets/addressBook.svg";
import converter from "../../public/assets/converterBanner.svg";
import burnerWallet from "../../public/assets/burnerWallet.svg";
import Link from "next/link";
import Upright from "public/svg/Upright";
import NetworkSwitcher from "./components/lib/NetworkSwitcher";
import Header from "./components/internal/Header";
import AddTokenButton from "./components/lib/AddToken";
import { useEffect, useState } from "react";
import { cairo, Contract } from "starknet";
import todoAbi from "./Abis/todoAbi.json";
import { useAccount } from "@starknet-react/core";
import { feltToString } from "./helper";

export default function Home() {
  const [todo, setTodo] = useState("");
  const contractAddr = "0x01250ad1d1d74c69d73c342c41cebb5d796e98c8b9873604635ebae5fadb8b38";
  // 0x05e82693e9faeadb7fb39921ffffe509950dbab382f250e36f04f6afcad7718c
  const {account} = useAccount();

  const todoContract = new Contract(todoAbi, contractAddr, account);

  const [todos, setTodos] = useState<[{title: String, isDone: boolean}]>();
  useEffect(() => {
    const fetchData = async () => {
      let response = await todoContract.get_all_todos();

      console.log(response);
      setTodos(response);
    }

    fetchData()
  }, []);

  const handleAddTodo = async () => {
    // alert(todo);
    try{
      await todoContract.add_todo(cairo.felt(todo));
      setTodo('')
    }catch(error){
      console.log(error)
      alert(error)
    }
  }
  return (
    <main className="flex min-h-svh flex-col justify-between gap-16">
      <Header />
      <div className="grid grid-cols-2 w-full mt-[250px]">
        <div className="m-auto p-5 bg-state-300 rounded-md flex flex-col w-9/12 gap-y-4">
          <h4 className="font-bold">Add Todo</h4>
          <input type="text" placeholder="enter todo title.." className="p-2" value={todo} onChange={(e) => {setTodo(e.target.value)}}/>
          <button onClick={handleAddTodo} className="p-4 bg-orange-400">Add Todo</button>
        </div>

        <div className="bg-white flex flex-col gap-y-4 p-5">
          <h4 className="font-bold text[30px]">All Todos</h4>
          <div className="flex gap-y-4 flex-col gap-y-2">
            {todos && todos.length > 0 ? todos.map((todo, index) =>(
              <div className="flex gap-x-4 p-2 bg-orange-200">
                <p>{index + 1}.</p>
                <p>{feltToString(todo?.title)}</p>
              </div>
            )): <p>No todos yet</p>}
          </div>

        </div>
      </div>
    </main>
  );
}

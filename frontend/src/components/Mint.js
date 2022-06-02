import React,{useEffect, useState} from 'react'
import { ethers, utils } from 'ethers';
import { Abi, contractAddress } from './Abi';
import "../mint.css"

export default function Mint() {


    const provider = new ethers.providers.Web3Provider(window.ethereum);
    const contractInst = new ethers.Contract(contractAddress , Abi, provider.getSigner())

    const [mintedNFT, setMintedNft]  = useState(0)

    useEffect(() => {
      
       mintedNft()

    })
    
    async function mintNFT(){

        const txData = {
            value: ethers.utils.parseUnits('0', 'ether'), gasLimit: 250000
        }
        const getNft = await contractInst.mint(txData)
        mintedNft()
    }   
    async function mintedNft(){
        let m = await contractInst.totalSupply()
        // console.log(m.toString())
        setMintedNft(m.toString())
    }

    return (
        <div>

        <div className="container my-5">
        <div className="row align-items-center">

        <div className="col">
            <img className="img-fluid new1 my-10" style={{width : "80%"}} src="3.png"  alt="marconi"/>
            <h3 className='my-2'>Get Your NFT </h3>
        </div>

        <div className="col my-12" >
            <h1>Mint Your NFT</h1>
            <br />
            <button className="mintBtn my-2" onClick={mintNFT}>Mint</button>
            <br />
            <h4 className="mintNumber my-3">Total Mint {mintedNFT} / 50</h4>
            <p>Mint will cost you 0 ETH</p>
            <p>Please choose Rinkeby Test Network</p>
            {/* <button className="mintBtn my-2" onClick={getMetadata}>getMetadata</button> */}

            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
        </div>
   
    </div>
    </div> 
    </div>
  )
}

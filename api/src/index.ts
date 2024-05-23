import "dotenv/config";
import { getFullnodeUrl, SuiClient } from "@mysten/sui.js/client";
import { Ed25519Keypair } from "@mysten/sui.js/keypairs/ed25519";
import { env } from "./config";

const rpcUrl = getFullnodeUrl("testnet");
const client = new SuiClient({ url: rpcUrl });
const keypair = Ed25519Keypair.deriveKeypair(env.MNEMONICS);
const address_1 = keypair.getPublicKey().toSuiAddress();

console.log(`Wallet address 1: ${address_1}`);

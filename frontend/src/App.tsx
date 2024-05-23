import SuiProvider from "./providers/SuiProvider"
import { ConnectButton } from '@mysten/dapp-kit';
function App() {
  return (
    <SuiProvider>
      <div className="m-5">
        <ConnectButton />
      </div>
    </SuiProvider>
  )
}

export default App

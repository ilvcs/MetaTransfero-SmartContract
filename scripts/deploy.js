const hre = require('hardhat')
const main = async () => {
  const transactionsFactory = await hre.ethers.getContractFactory(
    'UserTransactions',
  )
  const userTransactionsContract = await transactionsFactory.deploy()

  await userTransactionsContract.deployed()

  console.log(
    `User Transactions Deployed at Address: ${userTransactionsContract.address}`,
  )
}

const runMain = async () => {
  try {
    await main()
    process.exit(0)
  } catch (error) {
    console.error(error)
    process.exit(1)
  }
}

runMain()

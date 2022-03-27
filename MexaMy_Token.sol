// SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

/**
 * @dev Interface of the BEP20.
 */
interface BEP20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address from, address to, uint256 amount) external returns (bool);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/**
 * @dev Collection of functions related to the address type.
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        /** 
         * @dev This method relies on extcodesize/address.code.length, which returns 0
         * for contracts in construction, since the code is only stored at the end
         * of the constructor execution.
         */

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data, string memory errorMessage) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(bool success, bytes memory returndata, string memory errorMessage) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

/**
 * @dev Contract module that helps prevent reentrant calls to a function.
 *
 * Inheriting from `ReentrancyGuard` will make the {nonReentrant} modifier
 * available, which can be applied to functions to make sure there are no nested
 * (reentrant) calls to them.
 *
 * Note that because there is a single `nonReentrant` guard, functions marked as
 * `nonReentrant` may not call one another. This can be worked around by making
 * those functions `private`, and then adding `external` `nonReentrant` entry
 * points to them.
 *
 * TIP: If you would like to learn more about reentrancy and alternative ways
 * to protect against it, check out our blog post
 * https://blog.openzeppelin.com/reentrancy-after-istanbul/[Reentrancy After Istanbul].
 */
abstract contract ReentrancyGuard {
    // Booleans are more expensive than uint256 or any type that takes up a full
    // word because each write operation emits an extra SLOAD to first read the
    // slot's contents, replace the bits taken up by the boolean, and then write
    // back. This is the compiler's defense against contract upgrades and
    // pointer aliasing, and it cannot be disabled.

    // The values being non-zero value makes deployment a bit more expensive,
    // but in exchange the refund on every call to nonReentrant will be lower in
    // amount. Since refunds are capped to a percentage of the total
    // transaction's gas, it is best to keep them low in cases like this one, to
    // increase the likelihood of the full refund coming into effect.
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @dev Prevents a contract from calling itself, directly or indirectly.
     * Calling a `nonReentrant` function from another `nonReentrant`
     * function is not supported. It is possible to prevent this from happening
     * by making the `nonReentrant` function external, and making it call a
     * `private` function that does the actual work.
     */
    modifier nonReentrant() {
        // On the first call to nonReentrant, _notEntered will be true
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        // Any calls to nonReentrant after this point will fail
        _status = _ENTERED;

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        _status = _NOT_ENTERED;
    }
}

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

/**
 * @dev Interface of PancakeSwapV2 Factory.
 */
interface PancakeSwapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint) external view returns (address pair);
    function allPairsLength() external view returns (uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

/**
 * @dev Interface of PancakeSwapV2 Pair.
 */
interface PancakeSwapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(address indexed sender, uint amount0In, uint amount1In, uint amount0Out, uint amount1Out, address indexed to);
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

/**
 * @dev Interface of PancakeSwapV2 Router01.
 */
interface PancakeSwapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(address tokenA, address tokenB, uint amountADesired, uint amountBDesired, uint amountAMin, uint amountBMin, address to, uint deadline)
        external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(address token, uint amountTokenDesired, uint amountTokenMin, uint amountETHMin, address to, uint deadline)
        external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline)
        external returns (uint amountA, uint amountB);
    function removeLiquidityETH(address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline)
        external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(address tokenA, address tokenB, uint liquidity, uint amountAMin, uint amountBMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s)
        external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s)
        external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external returns (uint[] memory amounts);
    function swapTokensForExactTokens(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external payable returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external payable returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

/**
 * @dev Interface of PancakeSwapV2 Router02.
 */
interface PancakeSwapV2Router02 is PancakeSwapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline)
        external returns (uint amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(address token, uint liquidity, uint amountTokenMin, uint amountETHMin, address to, uint deadline, bool approveMax, uint8 v, bytes32 r, bytes32 s)
        external returns (uint amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(uint amountOutMin, address[] calldata path, address to, uint deadline) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline) external;
}

/**
 * @dev Implementation of the Smart Contract for the MexaMy token.
 */
contract MexaMyToken is BEP20, Context, Ownable, ReentrancyGuard {
    using Address for address;
    using SafeMath for uint256;

    mapping (address => uint256) private _rOwned;
    mapping (address => uint256) private _tOwned;
    mapping (address => mapping (address => uint256)) private _allowances;

    mapping(address => bool) private _isExcludedFromFee;
    mapping(address => bool) private _isExcluded;
    mapping(address => bool) private _Whitelisted;
    mapping(address => bool) private _Blacklisted; //Reserved for bot or malicious accounts.
    address[] private _excluded;

    uint256 private constant MAX = ~uint256(0);
    uint256 private constant _tTotal = 25e6 * 10**9;
    uint256 private _rTotal = (MAX - (MAX % _tTotal));
    uint256 private _tFeeTotal;

    string private constant _name = "MexaMy";
    string private constant _symbol = "MXMY";
    uint256 private constant _decimals = 9;

    uint256 public taxFee = 4;
    uint256 private _previousTaxFee = taxFee;

    uint256 public liquidityFee = 1;
    uint256 private _previousLiquidityFee = liquidityFee;

    uint256 public charityFee = 1;
    uint256 private _previousCharityFee = charityFee;
    address public CharityWallet = 0x4ef600B5353C7712D055C2d465A34E995654fDe1;

    uint256 public devFee = 1; //Development & Marketing
    uint256 private _previousDevFee = devFee;
    address public DevelopmentWallet = 0x507338357031cA783508c13A963C56D48217d2B0;

    uint256 public burnFee = 2; 
    uint256 private _previousBurnFee = burnFee;
    address public constant Burn_Address = 0x000000000000000000000000000000000000dEaD;

    uint256 public constant maxFee = 10; // taxFee + liquidtyFee + charityfee + devFee + burnFee <= 10
    uint256 public constant maxTokensBurned =  5e6 * 10**9; // 20% of total supply
    uint256 public maxTxAmount = 25e3 * 10**9; // 0.1% of total supply
    uint256 public maxBalance = 125e3 * 10**9; // 0.5% of total supply
    uint256 public numTokensSellToAddToLiquidity = 125e3 * 10**9; // 0.5% of total supply

    PancakeSwapV2Router02 public pancakeswapV2Router;
    address public pancakeswapV2Pair;

    bool inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;

    /**
     * @dev Events
     */
    event SwapAndLiquifyEnabledUpdated(bool enabled);
    event SwapAndLiquify(uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiquidity);
    event LiquidityAdded(uint256 tokenAmount, uint256 bnbAmount);
    event SwapAndLiquifyStatus(string status);
    event ExcludeFromFee(address account, bool value);
    event IncludeInFee(address account, bool value);
    event NewFees(uint256 _taxfee, uint256 _liquidityFee, uint256 _devFee, uint256 _charityFee, uint256 _burnFee);
    event FeesEnabled(bool value);
    event NewMaxTxAmount(uint256 amount);
    event NewMaxBalance(uint256 amount);
    event NewCharityWallet(address newCharityWallet);
    event NewDevWallet(address newDevWallet);
    event NumTokensSellToAddToLiquidity(uint256 amount);
    event WhitelistedUptaded(address account, bool value);
    event BlacklistedUpdated(address account, bool value);
    event RecoverTokens(uint256 tokenAmount);
   
    modifier lockTheSwap {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }

    constructor () {
        _rOwned[_msgSender()] = _rTotal;

        PancakeSwapV2Router02 _pancakeswapV2Router = PancakeSwapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);

        /**
         * @dev Create a PancakeSwap Pair for this new token.
         */
        pancakeswapV2Pair = PancakeSwapV2Factory(_pancakeswapV2Router.factory())
        .createPair(address(this), _pancakeswapV2Router.WETH());

        /**
         * @dev Set the rest of the contract variables .
         */
        pancakeswapV2Router = _pancakeswapV2Router;

        /**
         * @dev Exclude owner and this contract from Fee.
         */
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[address(CharityWallet)] = true;
        _isExcludedFromFee[address(DevelopmentWallet)] = true;

        /**
         * @dev Whitelisted.
         */
        _Whitelisted[owner()] = true;
        _Whitelisted[address(this)] = true;
        _Whitelisted[address(CharityWallet)] = true;
        _Whitelisted[address(DevelopmentWallet)] = true;
        _Whitelisted[address(Burn_Address)] = true;
        _Whitelisted[address(pancakeswapV2Pair)] = true;

        /**
         * @dev Excluded from Rewards Token.
         */
        _isExcluded[address(Burn_Address)] = true;

        emit Transfer(address(0), owner(), _tTotal);
    }

    /**
     * @dev To receive BNB from PancakeSwapV2Router02 when swapping.
     */
    receive() external payable {}

    /**
     * @dev Returns the name of the token.
     */
    function name() public pure returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() public pure returns (uint256) {
        return _decimals;
    }

    /**
     * @dev Returns total supply of token.
     */
    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    /**
     * @dev See balance of the address.
     */
    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tOwned[account];
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    
    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) external virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) external virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
        return true;
    }

    function reflectionFromToken(uint256 tAmount, bool deductTransferFee) external view returns(uint256) {
        require(tAmount <= _tTotal, "Amount must be less than supply");
        if (!deductTransferFee) {
            (uint256 rAmount , , , , , ) = _getValues(tAmount);
            return rAmount;
        } else {
            (,uint256 rTransferAmount , , , , ) = _getValues(tAmount);
            return rTransferAmount;
        }
    }

    function tokenFromReflection(uint256 rAmount) public view returns (uint256) {
        require(rAmount <= _rTotal, "Amount must be less than total reflections");
        uint256 currentRate = _getRate();
        return rAmount.div(currentRate);
    }

    function excludeFromReward(address account) external onlyOwner() {
        require(account != 0x10ED43C718714eb63d5aA57B78B54704E256024E, "We can not exclude PancakeSwap router.");
        require(!_isExcluded[account], "Account is already excluded"); 
        if(_rOwned[account] > 0) {
            _tOwned[account] = tokenFromReflection(_rOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    function includeInReward(address account) external onlyOwner() {
        require(_isExcluded[account], "Account is not included");
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _rOwned[account] = _tOwned[account].mul(_getRate());
                _tOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    function isExcludedFromReward(address account) external view returns (bool) {
        return _isExcluded[account];
    }

    function _transferBothExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);        
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _getValues(uint256 tAmount) private view returns (uint256, uint256, uint256, uint256, uint256, uint256) {
        (uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getTValues(tAmount);
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee) = _getRValues(tAmount, tFee, tLiquidity, _getRate());
        return (rAmount, rTransferAmount, rFee, tTransferAmount, tFee, tLiquidity);
    }

    function _getTValues(uint256 tAmount) private view returns (uint256, uint256, uint256) {
        uint256 tFee = calculateTaxFee(tAmount);
        uint256 tLiquidity = calculateLiquidityFee(tAmount);
        uint256 tTransferAmount = tAmount.sub(tFee).sub(tLiquidity);
        return (tTransferAmount, tFee, tLiquidity);
    }

    function _getRValues(uint256 tAmount, uint256 tFee, uint256 tLiquidity, uint256 currentRate) private pure returns (uint256, uint256, uint256) {
        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rFee = tFee.mul(currentRate);
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rFee).sub(rLiquidity);
        return (rAmount, rTransferAmount, rFee);
    }
    
    function _getRate() private view returns(uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _getCurrentSupply() private view returns(uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;      
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_rOwned[_excluded[i]] > rSupply || _tOwned[_excluded[i]] > tSupply) return (_rTotal, _tTotal);
            rSupply = rSupply.sub(_rOwned[_excluded[i]]);
            tSupply = tSupply.sub(_tOwned[_excluded[i]]);
        }
        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }

    function _takeLiquidity(uint256 tLiquidity) private {
        uint256 currentRate = _getRate();
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        _rOwned[address(this)] = _rOwned[address(this)].add(rLiquidity);
        if (_isExcluded[address(this)])
            _tOwned[address(this)] = _tOwned[address(this)].add(tLiquidity);
    }

    function calculateTaxFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(taxFee).div(10**2);
    }

    function calculateLiquidityFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(liquidityFee).div(10**2);
    }

    /**
     * @dev Set All Fees
     * Requirements: The sum of all fees must be less than or equal to maxFees.
     */
    function setAllFees(uint256 _taxFee, uint256 _liquidityFee, uint256 _charityFee, uint256 _devFee, uint256 _burnFee) external onlyOwner() {
        require(_taxFee.add(_liquidityFee).add(_charityFee).add(_devFee).add(_burnFee) <= maxFee);
        taxFee = _taxFee;
        liquidityFee = _liquidityFee;
        charityFee = _charityFee;
        devFee = _devFee;
        burnFee = _burnFee;
        emit NewFees(_taxFee, _liquidityFee, _charityFee, _devFee, _burnFee);
    }

    function removeAllFee() private {
        taxFee = 0;
        liquidityFee = 0;
        charityFee = 0;
        devFee = 0;
        burnFee = 0;
    }
    
    function restoreAllFee() private {
        taxFee = 4;
        liquidityFee = 1;
        charityFee = 1;
        devFee = 1;
        burnFee = 2;
    }

    /**
     * @dev Call this function to disable all Fees.
     * It will be necessary during the Presale stage.
     */
    function disableAllFees() external onlyOwner() {
        taxFee = 0;
        _previousTaxFee = taxFee;
        liquidityFee = 0;
        _previousLiquidityFee = liquidityFee;
        charityFee = 0;
        _previousCharityFee = charityFee;
        devFee = 0;
        _previousDevFee = devFee;  
        burnFee = 0;
        _previousBurnFee = burnFee;
        emit FeesEnabled(false);        
    }

    /**
     * @dev Call this function to enable Fees after finalizing the Presale.
     */
    function enableAllFees() external onlyOwner() {
        taxFee = 4;
        _previousTaxFee = taxFee;
        liquidityFee = 1;
        _previousLiquidityFee = liquidityFee;
        devFee = 1;
        _previousDevFee = devFee;
        charityFee = 1;
        _previousCharityFee = charityFee;
        burnFee = 2;
        _previousBurnFee = burnFee;
        emit FeesEnabled(true);
    }

    /**
     *@dev Set MaxTxAmount 
     * Requirements: New MaxTxAmount must be greater than 0 and less than or equal to 0.1% of total supply 
     */
    function setMaxTxAmount(uint256 amount) external onlyOwner() {
        require(amount > 0 && amount <= _tTotal.mul(1).div(1000)); // 0.1% of total supply
        maxTxAmount = amount;
        emit NewMaxTxAmount(amount);
    } 
    
    /**
     * @dev Set MaxBalance
     * Requirements: New MaxBalance must be less than or equal to 0.5% of total supply
     */
    function setMaxBalance(uint256 amount) external onlyOwner() {
        require(amount > 0 && amount <= _tTotal.mul(5).div(1000)); // 0.5% of total supply
        maxBalance = amount;
        emit NewMaxBalance(amount);
    }

    /**
     * @dev Set Number of Tokens to Add to Liquidity 
     * Requirements: The new amount must be greater than or equal to 0 and less than or equal to MaxTxAmount.
     */
    function setNumTokensSellToAddToLiquidity(uint256 amount) external onlyOwner {
        require(amount >= 0 && amount <= maxTxAmount);
        numTokensSellToAddToLiquidity = amount;
        emit NumTokensSellToAddToLiquidity(amount);
    }

    /**
     * @dev Set New Address Charity.
     * Requirements: The Charity Wallet cannot be the zero address.
     */
    function setCharityWallet(address newCharityWallet) external onlyOwner {
        require(newCharityWallet != address(0),
        "BEP20: The new wallet cannot be the zero address");
        CharityWallet = newCharityWallet;
        emit NewCharityWallet(newCharityWallet);
    }

    /**
     * @dev Set New address Development.
     * Requirements: The Development wallet cannot be the zero address.
     */
    function setDevelopmentWallet(address newDevWallet) external onlyOwner() {
        require(newDevWallet != address(0), 
        "BEP20: The new wallet cannot be the zero address.");
        DevelopmentWallet = newDevWallet;
        emit NewDevWallet(newDevWallet);
    }

    function _reflectFee(uint256 rFee, uint256 tFee) private {
        _rTotal = _rTotal.sub(rFee);
        _tFeeTotal = _tFeeTotal.add(tFee);
    }

    function totalFees() external view returns (uint256) {
        return _tFeeTotal;
    }

    function totalBurned() external view returns (uint256) {
		return balanceOf(Burn_Address);
	}

    /**
     * @dev The MexaMy Team may exclude certain accounts from the fees.
     */   
    function excludeFromFee(address account) external onlyOwner {
        _isExcludedFromFee[account] = true;
        emit ExcludeFromFee(account, true);
    }

     /**
     * @dev The MexaMy Team may include certain accounts in the fees.
     */           
    function includeInFee(address account) external onlyOwner {
        _isExcludedFromFee[account] = false;
        emit IncludeInFee(account, true);
    }

    function isExcludedFromFee(address account) external view returns(bool) {
        return _isExcludedFromFee[account];
    }

    /**
     * @dev The Mexamy Team can whitelist specific accounts.
     */
    function addToWhitelist(address account) external onlyOwner {
        _Whitelisted[account] = true;
        emit WhitelistedUptaded(account, true);
    }

    /**
     * @dev The Mexamy Team can remove specific accounts of whitelist.
     */
    function revomeToWhitelist(address account) external onlyOwner {
        _Whitelisted[account] = false;
        emit WhitelistedUptaded(account, false);
    }

    function Whitelisted(address account) external view returns(bool) {
        return _Whitelisted[account];
    }

    /**
     * @dev The Mexamy Team can blacklist specific accounts.
     */
    function addToBlacklist(address account) external onlyOwner {
        _Blacklisted[account] =true;
        emit BlacklistedUpdated(account, true);
    }

    
    /**
     * @dev The Mexamy Team can remove specific accounts of blacklist.
     */
    function removeToBlacklist(address account) external onlyOwner {
        _Blacklisted[account] = false;
        emit BlacklistedUpdated(account, false);
    }

    function Blacklisted(address account) external view returns(bool) {
        return _Blacklisted[account];
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(address from, address to, uint256 amount) private {
        require(from != address(0), "BEP20: transfer from the zero address");
        require(to != address(0), "BEP20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(amount <= balanceOf(from), "Transfer amount exceeds your balance");
        require(!_Blacklisted[to], "Sorry you can't receive tokens");
        if(!_Whitelisted[from] && !_Whitelisted[to]) {
            require(amount <= maxTxAmount, "Transfer amount exceeds MaxTxAmount");
            require(balanceOf(to).add(amount) <= maxBalance, "Recipient exceeds MaxBalance");
        } else {
            (_Blacklisted[from]); {
                require(to == CharityWallet, "Sorry you can only send tokens to Charity Wallet");
            } //If you are Blacklisted, contact the MexaMy Team to review your account and support in case of a possible appeal.
        }

        /**
         * @dev Stop Burn tokens when maxTokensBurned is reached.
         */
        uint256 tokensBurned = balanceOf(address(Burn_Address));
        if(tokensBurned >= maxTokensBurned) {
            burnFee = 0;
        }

        /* 
         *@dev Is the token balance of this contract address over the min number of
         * tokens that we need to initiate a swap + liquidity lock?
         * also, don't get caught in a circular liquidity event.
         * also, don't swap & liquify if sender is uniswap pair.
         */
        uint256 contractTokenBalance = balanceOf(address(this));
        
        bool overMinTokenBalance = contractTokenBalance >= numTokensSellToAddToLiquidity;
        if (overMinTokenBalance && !inSwapAndLiquify && from != pancakeswapV2Pair && swapAndLiquifyEnabled) {
            contractTokenBalance = numTokensSellToAddToLiquidity;
            /*
             *@dev Add Liquidity.
             */
            swapAndLiquify(contractTokenBalance);
        }
        
        /*
         *@dev Transfer amount, it will take tax, burn, liquidity fee.
         */
        _tokenTransfer(from,to,amount);
    }

    function swapAndLiquify(uint256 contractTokenBalance) private lockTheSwap {
        /*
         *@dev Split the contract balance into halves.
         */
        uint256 half = contractTokenBalance.div(2);
        uint256 otherHalf = contractTokenBalance.sub(half);

        /*
         *@dev Capture the contract's current BNB balance.
         * this is so that we can capture exactly the amount of BNB that the
         * swap creates, and not make the liquidity event include any BNB that
         * has been manually sent to the contract.
        */
        uint256 initialBalance = address(this).balance;

        /*
         *@dev Swap tokens for BNB.
         */
        swapTokensForBNB(half); // <- this breaks the BNB -> MXMY swap when swap+liquify is triggered.

        /*
         *@dev How much BNB did we just swap into?
         */
        uint256 newBalance = address(this).balance.sub(initialBalance);

        /*
         *@dev Add liquidity to PancakeSwap.
         */
        addLiquidity(otherHalf, newBalance);
        
        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForBNB(uint256 tokenAmount) private returns (bool status) {
        /*
         *@dev Generate the PancakeSwap pair path of TOKEN -> WBNB.
         */
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pancakeswapV2Router.WETH();

        _approve(address(this), address(pancakeswapV2Router), tokenAmount);

        /*
         *@dev Make the swap.
         */
        try pancakeswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, /* Accept any amount of BNB*/
            path,
            address(this),
            block.timestamp
        ) {
            emit SwapAndLiquifyStatus("Success");
            return true;
        }   
        catch {
            emit SwapAndLiquifyStatus("Failed");
            return false;
        }
    }

    function addLiquidity(uint256 tokenAmount, uint256 bnbAmount) private {
        /*
         *@dev Approve token transfer to cover all possible scenarios.
         */
        _approve(address(this), address(pancakeswapV2Router), tokenAmount);

        /*
         *@dev Add the liquidity.
         */
        pancakeswapV2Router.addLiquidityETH{value: bnbAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(this),
            block.timestamp
        );
        emit LiquidityAdded(tokenAmount, bnbAmount);
    }

    function setSwapAndLiquifyEnabled(bool _enabled) external onlyOwner {
        swapAndLiquifyEnabled = _enabled;
        emit SwapAndLiquifyEnabledUpdated(_enabled);
    }

    /*
     *@dev This method is responsible for taking all fee, if takeFee is true.
     */
    function _tokenTransfer(address sender, address recipient, uint256 amount) private {
        if(_isExcludedFromFee[sender] || _isExcludedFromFee[recipient]){
            removeAllFee();
        }
        
        /**
         * @dev Calculate Development Amount && Burn Amount.
         */
        uint256 charityAmt = amount.mul(charityFee).div(100);
        uint256 devAmt = amount.mul(devFee).div(100);
        uint256 burnAmt = amount.mul(burnFee).div(100);
        
        if (_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferFromExcluded(sender, recipient, (amount.sub(charityAmt).sub(devAmt).sub(burnAmt)));
        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {
            _transferToExcluded(sender, recipient, (amount.sub(charityAmt).sub(devAmt).sub(burnAmt)));
        } else if (_isExcluded[sender] && _isExcluded[recipient]) {
            _transferBothExcluded(sender, recipient, (amount.sub(charityAmt).sub(devAmt).sub(burnAmt)));
        } else {
            _transferStandard(sender, recipient, (amount.sub(charityAmt).sub(devAmt).sub(burnAmt)));
        }
        
        /**
         * @dev Temporarily remove fees to transfer to Development Wallet and Burn Address.
         */
        taxFee = 0;
        liquidityFee = 0;

        /**
         * @dev Send transfers to Development Wallet and Burn Address.
         */
        _transferStandard(sender, CharityWallet, charityAmt);
        _transferStandard(sender, DevelopmentWallet, devAmt);
        _transferStandard(sender, Burn_Address, burnAmt);
        

        /**
         * @dev Restore tax, liquidity and charity.
         */
        taxFee = _previousTaxFee;
        liquidityFee = _previousLiquidityFee;

        if(_isExcludedFromFee[sender] || _isExcludedFromFee[recipient])
            restoreAllFee();
    }

    function _transferStandard(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferToExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);           
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }


    function _transferFromExcluded(address sender, address recipient, uint256 tAmount) private {
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee, uint256 tTransferAmount, uint256 tFee, uint256 tLiquidity) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);   
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    /**
     * @dev Allows to recover any token BEP20 sent into the contract for error
     * or in the result of the swapAndLiquify function.
     * The Mexamy Team will allocate the recovered tokens for charity.
     */
    function recoverTokens(address tokenAddress, uint256 tokenAmount) external nonReentrant onlyOwner {
        BEP20(tokenAddress).transfer(CharityWallet, tokenAmount);
        emit RecoverTokens(tokenAmount);
    }

    /**
     * @dev Update the Router address if PancakeSwap upgrades to a newer version.
     */
    function setRouterAddress(address newRouter) external onlyOwner {
        PancakeSwapV2Router02 _newRouter = PancakeSwapV2Router02(newRouter);
        address get_pair = PancakeSwapV2Factory(_newRouter.factory()).getPair(address(this), _newRouter.WETH());
        //checks if pair already exists
        if (get_pair == address(0)) {
            pancakeswapV2Pair = PancakeSwapV2Factory(_newRouter.factory()).createPair(address(this), _newRouter.WETH());
        }
        else {
            pancakeswapV2Pair = get_pair;
        }
            pancakeswapV2Router = _newRouter;
    }
}

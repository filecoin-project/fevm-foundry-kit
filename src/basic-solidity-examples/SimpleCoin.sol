// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

contract SimpleCoin {
    mapping(address => uint) private _balances;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    constructor() {
        _balances[tx.origin] = 10000;
    }

    function sendCoin(
        address receiver,
        uint amount
    ) public returns (bool sufficient) {
        if (_balances[msg.sender] < amount) return false;
        _balances[msg.sender] -= amount;
        _balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function getBalance(address addr) public view returns (uint) {
        return _balances[addr];
    }
}

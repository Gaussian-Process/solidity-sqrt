pragma solidity 0.8.10;

import "ds-test/test.sol";

import {FixedPointMathLib} from "../FixedPointMathLib.sol";

contract ContractTest is DSTest {
    function setUp() public {}

    function testFromSolmate() public {
        assertEq(FixedPointMathLib.sqrt(0), 0);
        assertEq(FixedPointMathLib.sqrt(1), 1);
        assertEq(FixedPointMathLib.sqrt(2704), 52);
        assertEq(FixedPointMathLib.sqrt(110889), 333);
        assertEq(FixedPointMathLib.sqrt(32239684), 5678);
    }

    function testFromSolmate(uint256 x) public {
        uint256 root = FixedPointMathLib.sqrt(x);
        uint256 next = root + 1;

        // Ignore cases where next * next overflows.
        unchecked {
            if (next * next < next) return;
        }

        assertTrue(root * root <= x && next * next > x);
    }

    // check exhaustively for x < 256
    function testSqrtLt256() public {
        for (uint i = 0; i < 16; i++) {
            uint maxJ = (i+1) * (i+1);
            for (uint j = i * i; j < maxJ; j++) {
                assertEq(FixedPointMathLib.sqrt(j), i);
            }
        }
    }

    function testMore() public {
        require(FixedPointMathLib.sqrt(99) == 9);
        require(FixedPointMathLib.sqrt(100) == 10);
        require(FixedPointMathLib.sqrt(1<<254) == 1<<127);
        require(FixedPointMathLib.sqrt(256<<240) == 1<<124);
    }

}

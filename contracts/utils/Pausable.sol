// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.18;

import "../storages/GlobalAppStorage.sol";

abstract contract Pausable {
    modifier whenNotGlobalPaused() {
        require(!GlobalAppStorage.layout().globalPaused, "Pausable: Global paused");
        _;
    }

    modifier whenNotLiquidationPaused() {
        require(!GlobalAppStorage.layout().globalPaused, "Pausable: Global paused");
        require(!GlobalAppStorage.layout().liquidationPaused, "Pausable: Liquidation paused");
        _;
    }

    modifier whenNotAccountingPaused() {
        require(!GlobalAppStorage.layout().globalPaused, "Pausable: Global paused");
        require(!GlobalAppStorage.layout().accountingPaused, "Pausable: Accounting paused");
        _;
    }

    modifier whenNotPartyAActionsPaused() {
        require(!GlobalAppStorage.layout().globalPaused, "Pausable: Global paused");
        require(!GlobalAppStorage.layout().partyAActionsPaused, "Pausable: PartyA actions paused");
        _;
    }

    modifier whenNotPartyBActionsPaused() {
        require(!GlobalAppStorage.layout().globalPaused, "Pausable: Global paused");
        require(!GlobalAppStorage.layout().partyBActionsPaused, "Pausable: PartyB actions paused");
        _;
    }

    modifier whenEmergencyMode(address partyB) {
        require(
            GlobalAppStorage.layout().emergencyMode ||
                GlobalAppStorage.layout().partyBEmergencyStatus[partyB],
            "Pausable: It isn't emergency mode"
        );
        _;
    }
}
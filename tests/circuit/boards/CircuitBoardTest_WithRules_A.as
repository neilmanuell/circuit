package circuit.boards
{
import circuit.api.Circuit;

public class CircuitBoardTest_WithRules_A extends BaseCircuitBoardTest
{
    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( true, true, true, true, true );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, false );
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
        assembleBoard();
        _circuitA.onStateChanged.add( onCircuitAChange ) ;

        switchOffPowerSupplyOne();


    }

    private function onCircuitAChange( circuit:Circuit ):void
    {
        if ( !circuit.isLive )
            _breakerAD.close();



    }



}
}

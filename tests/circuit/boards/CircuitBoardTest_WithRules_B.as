package circuit.boards
{
import circuit.api.Circuit;

public class CircuitBoardTest_WithRules_B extends BaseCircuitBoardTest
{


    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( true, true, true, true, false );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, false );
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
        assembleBoard();
        _circuitD.onStateChanged.add( onCircuitDChange ) ;
        _circuitE.onStateChanged.add( onCircuitEChange ) ;

        switchOffPowerSupplyTwo();


    }

    private function onCircuitDChange( circuit:Circuit ):void
    {
        if ( !circuit.isLive )
            _breakerAD.close();



    }
    private function onCircuitEChange( circuit:Circuit ):void
    {
        if ( !circuit.isLive )
            _breakerDE.open();
    }



}
}

package circuit.boards
{
public class CircuitBoardTest_PS1_off_PS2_on extends BaseCircuitBoardTest
{
    [Test]
    public function test():void
    {
        configureCircuit()
        assertLiveCircuits( false, false, false, false, true );
    }

    protected function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, true );
        assembleBoard();
        switchOnPowerSupplyTwo();
    }
}
}

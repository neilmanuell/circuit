package circuit.pathfinding
{
public class CircuitPathFinderTest_PS1_off_PS2_on extends BaseCircuitPathFinderTest
{


    [Test]
    public function test():void
    {
        runPathfinding();
        assertLiveCircuits( false, false, false, false, true );
    }

    protected override function configureCircuit():void
    {
        switchOnPowerSupplyTwo();
        configureOpenBreakers( false, false, true, true );
    }


}
}

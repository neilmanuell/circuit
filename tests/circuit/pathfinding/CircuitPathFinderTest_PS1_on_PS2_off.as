package circuit.pathfinding
{
public class CircuitPathFinderTest_PS1_on_PS2_off extends BaseCircuitPathFinderTest
{


    [Test]
    public function test():void
    {
       runPathfinding();
        assertLiveCircuits( true, true, true, false, false );
    }

    protected override function configureCircuit():void
    {
        switchOnPowerSupplyOne();
        configureOpenBreakers( false, false, true, true );
    }


}
}

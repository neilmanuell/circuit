package circuit.pathfinding
{
public class CircuitPathFinderTest_BothSuppliesOn_B extends BaseCircuitPathFinderTest
{


    [Test]
    public function test():void
    {
       runPathfinding();
        assertLiveCircuits( false, true, false, false, true );
    }

    protected override function configureCircuit():void
    {
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
        configureOpenBreakers( true, false, false, true );
    }


}
}

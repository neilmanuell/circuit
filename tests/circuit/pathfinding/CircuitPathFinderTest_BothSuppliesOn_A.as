package circuit.pathfinding
{
public class CircuitPathFinderTest_BothSuppliesOn_A extends BaseCircuitPathFinderTest
{


    [Test]
    public function both_powerSupplies_on():void
    {
        runPathfinding();
        assertLiveCircuits( true, true, true, false, true );
    }

    protected override function configureCircuit():void
    {
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
        configureOpenBreakers( false, false, true, true );
    }


}
}

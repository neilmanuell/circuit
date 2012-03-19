package circuit.pathfinding
{
public class CircuitPathFinderTest_BothSuppliesOn_C extends BaseCircuitPathFinderTest
{


    [Test]
    public function both_powerSupplies_on():void
    {
       runPathfinding();
        assertLiveCircuits( false, true, false, true, true );
    }

    protected override function configureCircuit():void
    {
        switchOnPowerSupplyOne();
        switchOnPowerSupplyTwo();
        configureOpenBreakers( true, true, true, false );
    }


}
}

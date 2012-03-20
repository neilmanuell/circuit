package circuit.pathfinding
{
public class CircuitPathFinderTest_BothSuppliesOff extends BaseCircuitPathFinderTest
{


    [Test]
    public function test():void
    {
        runPathfinding();
        assertLiveCircuits( false, false, false, false, false );
    }

    protected override function configureCircuit():void
    {
        configureOpenBreakers( false, false, true, true );
    }


}
}

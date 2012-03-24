package circuit.core
{
import circuit.api.PowerSupply;

public interface PowerSupplyConfig     extends PowerSupply
{
    function get circuit():CircuitOperate;
    function set circuit( value:CircuitOperate ):void;
}
}

package circuit.core
{
import circuit.api.Supply;

public interface PowerSupplyConfig extends Supply
{
    function get circuit():CircuitNodeOperate;

    function set circuit( value:CircuitNodeOperate ):void;
}
}

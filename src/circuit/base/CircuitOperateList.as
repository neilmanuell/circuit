package circuit.base
{
import circuit.core.*;

import flash.events.Event;

import mockolate.nice;
import mockolate.prepare;
import mockolate.received;

import org.flexunit.async.Async;
import org.hamcrest.assertThat;
import org.hamcrest.collection.array;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.isTrue;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.strictlyEqualTo;

public class CircuitOperateList
{
    private const _circuits:Array = [];
    private var _count:int = 0;

    public function get length():int
    {
        return _circuits.length;
    }

    public function add( circuit:CircuitOperate ):Boolean
    {
        if ( _circuits.indexOf( circuit ) != -1 )return false;
        _circuits.push( circuit );
        return true;
    }

    public function get hasNext():Boolean
    {
        return (_count < _circuits.length);
    }

    public function next():CircuitOperate
    {
        if ( !hasNext )return null;
        return _circuits[_count++];
    }

    public function reset():void
    {
        _count = 0
        _circuits.length = 0;
    }

    public function invalidateAll():void
    {
        for each (var circuit:CircuitOperate in _circuits)
            circuit.invalidate();
    }

    public function validateAll():void
    {
        for each (var circuit:CircuitOperate in _circuits)
            circuit.validate();
    }

    public function markAllAsConnected():void
    {
        for each (var circuit:CircuitOperate in _circuits)
            circuit.markAsConnected();
    }


}
}

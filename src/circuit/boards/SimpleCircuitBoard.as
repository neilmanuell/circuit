package circuit.boards
{
import circuit.api.CircuitBoardConfig;
import circuit.api.Edge;
import circuit.api.Node;
import circuit.api.Supply;
import circuit.base.CircuitOperateList;
import circuit.base.SimpleBreakerEdge;
import circuit.base.SimpleCircuitNode;
import circuit.base.SimplePowerSupply;
import circuit.core.CircuitBoard;
import circuit.pathfinding.CircuitPathFinder;

import flash.utils.Dictionary;

import net.lists.LinkedList;

public class SimpleCircuitBoard implements CircuitBoard, CircuitBoardConfig
{
    private const _map:Dictionary = new Dictionary( false );
    private const _edges:LinkedList = new LinkedList();
    private const _nodes:LinkedList = new LinkedList();
    private const _supplies:LinkedList = new LinkedList();
    private const _circuitOperateList:CircuitOperateList = new CircuitOperateList();
    private const _pathfinder:CircuitPathFinder = new CircuitPathFinder();
    private var _hasChanged:Boolean = false;
    private var _isPathFinding:Boolean = false;
    private const NODE_NAMESPACE:String = "node:";
    private const EDGE_NAMESPACE:String = "edge:";
    private const SUPPLY_NAMESPACE:String = "supply:";


    public function getEdgeInstance( id:String ):Edge
    {
        const key:String = EDGE_NAMESPACE + id;
        if ( _map[key] != null )return  _map[key];
        const edge:Edge = new SimpleBreakerEdge( id );
        _map[key] = edge;
        addEdge( edge );
        return edge;
    }

    public function hasEdge( edge:Edge ):Boolean
    {
        return _edges.has( edge );
    }

    public function getNodeInstance( id:String ):Node
    {
        const key:String = NODE_NAMESPACE + id;
        if ( _map[key] != null )return  _map[key];
        const node:Node = new SimpleCircuitNode( id );
        _map[key] = node;
        addNode( node );
        return node;
    }

    public function hasNode( node:Node ):Boolean
    {
        return _nodes.has( node );
    }

    public function getSupplyInstance( id:String ):Supply
    {
        const key:String = SUPPLY_NAMESPACE + id;
        if ( _map[key] != null )return  _map[key];
        const supply:Supply = new SimplePowerSupply( id );
        _map[key] = supply;
        addSupply( supply );
        return supply
    }

    public function hasSupply( supply:Supply ):Boolean
    {
        return _supplies.has( supply );
    }

    public function activate():void
    {
        pathfind();
    }

    private function pathfind():void
    {
        _hasChanged = false;
        _isPathFinding = true;
        _circuitOperateList.client = _nodes;
        _circuitOperateList.invalidateAll();
        _pathfinder.findConnectionsFromPowerSupplies( _supplies );
        _pathfinder.reset();
        _circuitOperateList.validateAll();
        _circuitOperateList.dispatchAll();
        _isPathFinding = false;

    }

    public function addEdge( breaker:Edge ):Boolean
    {
        if ( _edges.has( breaker ) ) return false;
        breaker.onStateChanged.add( onChildStateChanged );
        _edges.add( breaker );
        return true;
    }

    public function addNode( circuit:Node ):Boolean
    {
        if ( _nodes.has( circuit ) ) return false;
        _nodes.add( circuit );
        return true;
    }

    public function addSupply( powerSupply:Supply ):Boolean
    {
        if ( _supplies.has( powerSupply ) ) return false;
        powerSupply.onStateChanged.add( onChildStateChanged );
        _supplies.add( powerSupply );
        return true;
    }


    private function onChildStateChanged( item:* ):void
    {
        if ( _isPathFinding )
            _hasChanged = true;
        else
        {
            do {
                pathfind();
            }
            while ( _hasChanged )

        }
    }

}
}

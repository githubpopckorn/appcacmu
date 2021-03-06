import React from 'react';
import Paper from 'material-ui/Paper';
import RaisedButton from 'material-ui/RaisedButton';
import NumberFormat from 'react-number-format';
import {Table, TableBody, TableFooter, TableHeader, TableHeaderColumn, TableRow, TableRowColumn} from 'material-ui/Table';

class TablaCoshechas extends React.Component {
  constructor(props){
    super(props);
    this.state = {
      sumaCantidades: 0,
      sumaTotales: 0
    }
  }

  getBody(){
    let cantidades = this.props.cantidades;
    let saldos = this.props.saldos;
    let result = [];

    for(let yearKey in cantidades){
      result.push(
        <TableRow>
          <TableHeaderColumn colSpan="5" tooltip="Año" style={{textAlign: 'center', backgroundColor: "#3F51B5", color: 'white'}}>
            Reporte año { yearKey }
          </TableHeaderColumn>
        </TableRow>
      );
      let fila = this.getRow(yearKey);
      result.push(fila[0]);
      result.push(
        <TableRow style={{textAlign: 'center', backgroundColor: "#FFF176", fontWeight: "bold"}}>
          <TableRowColumn/>
          <TableRowColumn style={{textAlign: 'center'}}>TOTAL</TableRowColumn>
          <TableRowColumn style={{textAlign: 'center'}}>{ parseFloat(fila[1]).toFixed(2) }</TableRowColumn>
          <TableRowColumn style={{textAlign: 'center'}}>{ parseFloat(fila[2]).toFixed(2) }</TableRowColumn>
          <TableRowColumn/>
        </TableRow>
      );
      result.push(
        <TableRow>
          <TableHeaderColumn colSpan="5" tooltip="" style={{textAlign: 'center'}}>

          </TableHeaderColumn>
        </TableRow>
      );
    }

    return result;
  }

  getNombreMes(numero){
    switch(numero){
      case "01":
        return "Enero";
      case "02":
        return "Febrero";
      case "03":
        return "Marzo";
      case "04":
        return "Abril";
      case "05":
        return "Mayo";
      case "06":
        return "Junio";
      case "07":
        return "Julio";
      case "08":
        return "Agosto";
      case "09":
        return "Septiembre";
      case "10":
        return "Octubre";
      case "11":
        return "Noviembre";
      case "12":
        return "Diciembre";
    }
  }

  getRow(yearKey){
    let data = this.props.cantidades[yearKey];
    var sumaCantidad = 0;
    var sumaSaldo = 0;
    let result = [];

    for(let row in data){
      sumaCantidad += data[row];
      sumaSaldo += this.props.saldos[yearKey][row];

      result.push(
        <TableRow style={{textAlign: 'center'}}>
          <TableRowColumn style={{textAlign: 'center'}}>{ yearKey }</TableRowColumn>
          <TableRowColumn style={{textAlign: 'center'}}>{ this.getNombreMes(row) }</TableRowColumn>
          <TableRowColumn style={{textAlign: 'center'}}>{ data[row] }</TableRowColumn>
          <TableRowColumn style={{textAlign: 'center'}}>
            <NumberFormat value={ parseFloat(this.props.saldos[yearKey][row]).toFixed(2) } displayType={'text'} thousandSeparator={true}/>
          </TableRowColumn>
          <TableRowColumn>
            <RaisedButton label="Ver" backgroundColor={"#595753"} labelColor={"white"} onClick={()=>  this.props.onClick(yearKey, row)}/>
          </TableRowColumn>
        </TableRow>
      );
    }
    return [result, sumaCantidad, sumaSaldo];
  }

  render(){
    return(
      <div>
        <Paper zDepth={4} className="top-space">
          <div className="table-responsive">
            <Table fixedHeader={true} fixedFooter={true} selectable={false}>

              <TableHeader displaySelectAll={false} adjustForCheckbox={false}>
                <TableRow>
                  <TableHeaderColumn colSpan="5" tooltip="Reporte Mora" style={{textAlign: 'center'}}>
                    Reporte De Mora
                  </TableHeaderColumn>
                </TableRow>
                <TableRow>
                  <TableHeaderColumn tooltip="Año" style={{textAlign: 'center'}}>Año</TableHeaderColumn>
                  <TableHeaderColumn tooltip="Mes" style={{textAlign: 'center'}}>Mes</TableHeaderColumn>
                  <TableHeaderColumn tooltip="Cantidad" style={{textAlign: 'center'}}>Cantidad</TableHeaderColumn>
                  <TableHeaderColumn tooltip="Suma Cartera en Riesgo" style={{textAlign: 'center'}}>Suma Cartera</TableHeaderColumn>
                  <TableHeaderColumn tooltip="Visualizar" style={{textAlign: 'left'}}>Ver</TableHeaderColumn>
                </TableRow>
              </TableHeader>

              <TableBody displayRowCheckbox={false} stripedRows={false}>
                { this.getBody() }
              </TableBody>
            </Table>
          </div>
        </Paper>
      </div>
    );
  }
}

export default TablaCoshechas;

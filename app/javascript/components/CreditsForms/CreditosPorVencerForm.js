import React from 'react';
import ReactDOM from 'react-dom';
import moment from 'moment';


// Material ui
import getMuiTheme from 'material-ui/styles/getMuiTheme';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import RaisedButton from 'material-ui/RaisedButton';
import MenuItem from 'material-ui/MenuItem';
import Paper from 'material-ui/Paper';

// Formsy
import { FormsyDate } from 'formsy-material-ui';
import { FormsySelect } from 'formsy-material-ui';
import Formsy from 'formsy-react';
import FormsyText from 'formsy-material-ui/lib/FormsyText';

const muiTheme = getMuiTheme({
  palette: {
    primary1Color: "#3F51B5",
    accent1Color: "#FFC107",
    textColor: '#34495e'
  }
});


class CreditosPorVencerForm extends React.Component{

  constructor(props){
    super(props);
    this.state = {
      agencia: '',
      asesor: '',
      canSubmit: false,
      diaInicio: 0,
      diaFin: 0,
    }
  }

  submit(){
    ReactDOM.findDOMNode(this.refs.form).submit();
  }

  enableSubmitButton(){
    this.setState({
      canSubmit: true
    })
  }

  disableSubmitButton(){
    this.setState({
      canSubmit: false
    })
  }

  syncAgencia = (event, value, index) => {
    this.setState({
      agencia: value
    });
  };

  syncDiaInicio = (event, value) => {
    this.setState({
      diaInicio: value
    });
  };

  syncDiaFin = (event, value) => this.setState({
    diaFin: value
  });

  syncAsesor = (event, value, index) => this.setState({
    asesor: value
  });

  render(){
    return(
      <MuiThemeProvider muiTheme={getMuiTheme(muiTheme)}>
        <div>
          <Paper zDepth={3} rounded={true} className="padding top-space">
            <h5 style={{color: muiTheme.palette.accent1Color}}>{ this.props.title }</h5>
            <Formsy.Form
              onValid={()=> this.enableSubmitButton()}
              onValidSubmit={()=> this.submit()}
              onInvalid={ ()=> this.disableSubmitButton()}
              action={ this.props.url }
              method="post"
              ref="form">
              <div>
                <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} readOnly={true} />
                <input type="hidden" name="agencia" value={this.state.agencia} readOnly={true} />
                <input type="hidden" name="asesor" value={this.state.asesor} readOnly={true} />
                <input type="hidden" name="diaInicio" value={this.state.diaInicio} readOnly={true} />
                <input type="hidden" name="diaFin" value={this.state.diaFin} readOnly={true} />
              </div>

              <div>
                <FormsyText
                  floatingLabelStyle={{color: muiTheme.palette.primary1Color}}
                  floatingLabelText="Mora desde"
                  required
                  name="diaInicio"
                  type="number"
                  validations="isNumeric"
                  onChange={ (event, value) => this.syncDiaInicio(event, value) }
                  validationError="Introduce solo numeros"/>
              </div>
              <div>
                <FormsyText
                  floatingLabelStyle={{color: muiTheme.palette.primary1Color}}
                  floatingLabelText="Mora hasta"
                  required
                  name="diaFin"
                  type="number"
                  validations="isNumeric"
                  onChange={ (event, value) => this.syncDiaFin(event, value) }
                  validationError="Introduce solo numeros"/>
              </div>

              <div>
                <FormsySelect
                  style={{textAlign: 'left'}}
                  required
                  floatingLabelText="Escoge una agencia"
                  floatingLabelStyle={{color: muiTheme.palette.primary1Color}}
                  name="agencia"
                  onChange={this.syncAgencia}>
                  <MenuItem value={' '} primaryText="Todos" />
                  <MenuItem value={'Matriz'} primaryText="Matriz" />
                  <MenuItem value={'La Merced'} primaryText="La Merced" />
                  <MenuItem value={'Cuenca del Lago San Pablo'} primaryText="Cuenca del Lago San Pablo" />
                  <MenuItem value={'Cuenca del Rio Mira'} primaryText="Cuenca del Rio Mira" />
                  <MenuItem value={'Economia Solidaria'} primaryText="Economia Solidaria" />
                  <MenuItem value={'Frontera Norte'} primaryText="Frontera Norte" />
                  <MenuItem value={'Servim'} primaryText="Servimóvil" />
                  <MenuItem value={'Valle Fertil'} primaryText="Valle Fertil" />
                </FormsySelect>
              </div>
              <div>
                <FormsySelect
                  style={{textAlign: 'left'}}
                  required
                  floatingLabelText="Escoge un asesor"
                  floatingLabelStyle={{color: muiTheme.palette.primary1Color}}
                  name="asesor"
                  onChange={this.syncAsesor}>
                  <MenuItem value={' '} primaryText="Todos" />
                  <MenuItem value={'ALARCON JUAN CARLOS'} primaryText="ALARCON JUAN CARLOS" />
                  <MenuItem value={'ALMEIDA FRANCISCO'} primaryText="ALMEIDA FRANCISCO" />
                  <MenuItem value={'ANDRADE EDISON'} primaryText="ANDRADE EDISON" />
                  <MenuItem value={'BENAVIDES ROMEL'} primaryText="BENAVIDES ROMEL" />
                  <MenuItem value={'CATUCUAGO MARINA'} primaryText="CATUCUAGO MARINA" />
                  <MenuItem value={'CHAMORRO ANDRES'} primaryText="CHAMORRO ANDRES" />
                  <MenuItem value={'CHANDI SILVIA'} primaryText="CHANDI SILVIA" />
                  <MenuItem value={'CHANDI VERONICA'} primaryText="CHANDI VERONICA" />
                  <MenuItem value={'CHAPI BYRON'} primaryText="CHAPI BYRON" />
                  <MenuItem value={'DELGADO CRISTINA'} primaryText="DELGADO CRISTINA" />
                  <MenuItem value={'DUQUE GABRIELA'} primaryText="DUQUE GABRIELA" />
                  <MenuItem value={'HIDROBO STIWAR'} primaryText="HIDROBO STIWAR" />
                  <MenuItem value={'INSUASTI SANDRA'} primaryText="INSUASTI SANDRA" />
                  <MenuItem value={'PAREDES VICTORIA'} primaryText="PAREDES VICTORIA" />
                  <MenuItem value={'PAZMINO MARCELIA'} primaryText="PAZMINO MARCELIA" />
                  <MenuItem value={'RODRIGUEZ JORGE'} primaryText="RODRIGUEZ JORGE" />
                  <MenuItem value={'RODRIGUEZ WILLIAM'} primaryText="RODRIGUEZ WILLIAM" />
                  <MenuItem value={'SANCHEZ ANDREA'} primaryText="SANCHEZ ANDREA" />
                  <MenuItem value={'TERAN MARITZA'} primaryText="TERAN MARITZA" />
                </FormsySelect>
              </div>
              <div>
                <RaisedButton
                  primary={true}
                  type="submit"
                  label="Consultar"
                  disabled={ !this.state.canSubmit }
                  labelColor="#ffffff"
                  ref="submitButton"
                />
              </div>
            </Formsy.Form>
          </Paper>
        </div>
      </MuiThemeProvider>
    );
  }
}

export default CreditosPorVencerForm;
class CreditsController < ApplicationController

  def index
  end


  def creditos_por_vencer
    # Obtengo los creditos por semana
    @firstWeek = Oracledb.obtener_creditos_por_vencer Date.new(Date.current.year,Date.current.month,1), Date.new(Time.current.year,Time.current.month,7), params['agencia'], params['asesor'],'firstWeek'
    @secondWeek = Oracledb.obtener_creditos_por_vencer Date.new(Date.current.year,Date.current.month,8), Date.new(Time.current.year,Time.current.month,14), params['agencia'], params['asesor'],'secondWeek'
    @thirdWeek = Oracledb.obtener_creditos_por_vencer Date.new(Date.current.year,Date.current.month,15), Date.new(Time.current.year,Time.current.month,21), params['agencia'], params['asesor'],'thirdWeek'
    @fourthWeek = Oracledb.obtener_creditos_por_vencer Date.new(Date.current.year,Date.current.month,22), Date.new(Time.current.year,Time.current.month,-1), params['agencia'],params['asesor'],'fourthWeek'

    @firstWeek.each do |row|
      row['saldo'] = row['saldo'].to_f
      row['provision'] = row['provision'].to_f
    end


    @secondWeek.each do |row|
      row['saldo'] = row['saldo'].to_f
      row['provision'] = row['provision'].to_f
    end


    @thirdWeek.each do |row|
      row['saldo'] = row['saldo'].to_f
      row['provision'] = row['provision'].to_f
    end


    @fourthWeek.each do |row|
      row['saldo'] = row['saldo'].to_f
      row['provision'] = row['provision'].to_f
    end


    # Obtengo un array lleno de las fechas intermedias entre las semanas
    @firstArrayDates= Array.new
    (Date.new(Date.current.year,Date.current.month,1)..Date.new(Time.current.year,Time.current.month,7)).each do |date|
      @firstArrayDates.push(date.strftime('%d-%m-%Y'))
    end
    @secondArrayDates= Array.new
    (Date.new(Date.current.year,Date.current.month,8)..Date.new(Time.current.year,Time.current.month,14)).each do |date|
      @secondArrayDates.push(date.strftime('%d-%m-%Y'))
    end
    @thirdArrayDates= Array.new
    (Date.new(Date.current.year,Date.current.month,15)..Date.new(Time.current.year,Time.current.month,21)).each do |date|
      @thirdArrayDates.push(date.strftime('%d-%m-%Y'))
    end
    @fourthArrayDates= Array.new
    (Date.new(Date.current.year,Date.current.month,22)..Date.new(Time.current.year,Time.current.month,-1)).each do |date|
      @fourthArrayDates.push(date.strftime('%d-%m-%Y'))
    end

    # Creo un hash de arrays cuyas llaves son las fechas extraidas entre semanas
    @firstHash = Hash.new(Array.new)
    @firstArrayDates.each do |fecha|
      @firstHash[fecha] = []
    end

    @secondHash = Hash.new(Array.new)
    @secondArrayDates.each do |fecha|
      @secondHash[fecha] = []
    end

    @thirdHash = Hash.new(Array.new)
    @thirdArrayDates.each do |fecha|
      @thirdHash[fecha] = []
    end

    @fourthHash = Hash.new(Array.new)
    @fourthArrayDates.each do |fecha|
      @fourthHash[fecha] = []
    end


    # Lleno el hash con los creditos, clasificados por sus llaves y fechas
    @firstWeek.each do |credit|
      credit.stringify_keys!
      array = Array.new
      credit["fecha"] = credit["fecha"].to_date.strftime('%d-%m-%Y')
      array = @firstHash[credit["fecha"]]
      array.push(credit)
      @firstHash[credit["fecha"]] = array
    end

    @secondWeek.each do |credit|
      credit.stringify_keys!
      array = Array.new
      credit["fecha"] = credit["fecha"].to_date.strftime('%d-%m-%Y')
      array = @secondHash[credit["fecha"]]
      array.push(credit)
      @secondHash[credit["fecha"]] = array
    end

    @thirdWeek.each do |credit|
      credit.stringify_keys!
      array = Array.new
      credit["fecha"] = credit["fecha"].to_date.strftime('%d-%m-%Y')
      array = @thirdHash[credit["fecha"]]
      array.push(credit)
      @thirdHash[credit["fecha"]] = array
    end

    @fourthWeek.each do |credit|
      credit.stringify_keys!
      array = Array.new
      credit["fecha"] = credit["fecha"].to_date.strftime('%d-%m-%Y')
      array = @fourthHash[credit["fecha"]]
      array.push(credit)
      @fourthHash[credit["fecha"]] = array
    end


  end

  def creditos_vencidos

    if params['consulta_detalles_asesor'].present?
      @data = Oracledb.obtener_creditos_de_asesor params["asesor"]["nombre"]
      respond_to do |format|
        format.json { render :layout => false, :text => @data.to_json }
      end
      return
    end


    @tipoReporte = "asesor"
    @data = Oracledb.obtener_creditos_por_asesor params["fecha"], params["diaInicio"], params["diaFin"]



    # @tipoReporte = "agencia"
    # @data = Oracledb.obtener_creditos_por_agencia params["fecha"], params["diaInicio"], params["diaFin"]
    #  if params["tipoReporte"] == "asesor"
    #    @tipoReporte = "asesor"
    #    @data = Oracledb.obtener_creditos_por_asesor params["fecha"].to_date.strftime('%d-%m-%Y'), params["diaInicio"], params["diaFin"]
    #  else
    #    @tipoReporte = "agencia"
    #    @data = Oracledb.obtener_creditos_por_agencia params["fecha"].to_date.strftime('%d-%m-%Y'), params["diaInicio"], params["diaFin"]
    # end
  end

  def cosechas
  end

  def matrices
  end

  def clientes_vip
  end

  def set_layout
    return "creditos"
    super
  end
end
# == Schema Information
#
# Table name: goods
#
#  id                      :integer          not null, primary key
#  credit_id               :string
#  socio_id                :string
#  nombres                 :string
#  cedula                  :string
#  telefono                :string
#  celular                 :string
#  direccion               :string
#  sector                  :string
#  parroquia               :string
#  canton                  :string
#  nombre_grupo            :string
#  grupo_solidario         :string
#  sucursal                :string
#  oficial_credito         :string
#  cartera_heredada        :string
#  fecha_concesion         :string
#  fecha_vencimiento       :string
#  tipo_garantia           :string
#  garantia_real           :string
#  garantia_fiduciaria     :string
#  dir_garante             :string
#  tel_garante             :string
#  valor_cartera_castigada :string
#  bienes                  :string
#  tipo_credito            :string
#  good_stage_id           :integer
#  good_activity_id        :integer
#  estado                  :string
#  observaciones           :text
#  juicio_id               :string
#  fentrega_juicios        :date
#  fcalificacion_juicio    :date
#  codigo_juicio           :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  lawyer_id               :integer
#  fecha_terminacion       :string
#  fecha_original_juicio   :date
#  nom_garante1            :string
#  ci_garante_1            :string
#  cony_garante1           :string
#  nom_garante2            :string
#  ci_garante2             :string
#  cony_garante2           :string
#  propietario_bienes      :string
#  calificacion            :string
#  user_id                 :integer
#  valor_avaluo_comercial  :string
#  valor_avaluo_catastral  :string
#  avaluo_titulo           :string
#  interes                 :string
#  mora                    :string
#  gastos_judiciales       :string
#

class Good < ApplicationRecord
  searchkick
  belongs_to :good_stage
  belongs_to :good_activity
  belongs_to :lawyer
  belongs_to :user

  after_create :delete_pending, :unless => :skip_callbacks
  attr_accessor :callback_skip

  # Scopes
  scope :activos, -> { where(estado: "Activo") }
  scope :cancelados, -> { where(estado: "Cancelado") }
  scope :reingresos, -> { where(estado: "Reingreso") }
  scope :terminados, -> { where(estado: "Terminado") }
  scope :insolvencias, -> { where(estado: "Insolvencia") }
  scope :reestructurados, -> { where(estado: "Reestructurado") }
  scope :abandonados, -> { where(estado: "Abandono") }
  scope :ultimos, ->{ order("created_at DESC")}

  scope :activados, ->{ where(estado: ["Activo", "Reingreso", "Insolvencia", "Reestructurado"])}

  scope :sin_reestructurados, -> { where(estado: ["Activo", "Reingreso", "Insolvencia"]) }

  def etapa_estimada
    fecha_inicio = self.created_at.to_date
    dias_transcurridos = (Date.current - fecha_inicio)

    if dias_transcurridos >= ((fecha_inicio + 12.month) - fecha_inicio).to_i
      "Termina proceso"
    elsif dias_transcurridos >= ((fecha_inicio + 11.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 12.month) - fecha_inicio).to_i
      "Ejecución de remate"
    elsif dias_transcurridos >= ((fecha_inicio + 9.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 11.month) - fecha_inicio).to_i
      "Audiencia de ejecución"
    elsif dias_transcurridos >= ((fecha_inicio + 8.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 9.month) - fecha_inicio).to_i
      "Liquidación"
    elsif dias_transcurridos >= ((fecha_inicio + 7.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 8.month) - fecha_inicio).to_i
      "Sentencia"
    elsif dias_transcurridos >= ((fecha_inicio + 5.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 7.month) - fecha_inicio).to_i
      "Citaciones finalizadas - Razón"
    elsif dias_transcurridos >= ((fecha_inicio + 2.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 5.month) - fecha_inicio).to_i
      "Acta de sorteo judicial"
    elsif dias_transcurridos >= ((fecha_inicio + 1.month) - fecha_inicio).to_i and dias_transcurridos <= ((fecha_inicio + 2.month) - fecha_inicio).to_i
      "Documentos habilitantes"
    else
      "Autorización proceso judicial"
    end

  end

  def semaforo
    # Alamacenará la fecha de la etapa estimada del credito
    fecha_etapa_estimada = ''

    # Almacenará la fecha de la proxima etapa la que viene despues de la estimada
    fecha_proxima_etapa = ''

    # Almacena el numero de mes de la etapa
    mes = self.good_stage.months.to_i

    # Almacena la fecha de la etapa actual en la que se encuentra el juicio
    fecha_etapa_actual = (self.created_at + mes.month).to_date

    nombre_etapa_estimada = self.etapa_estimada
    case nombre_etapa_estimada
      when "Autorización proceso judicial"
        fecha_etapa_estimada = self.created_at
        fecha_proxima_etapa =  self.created_at + 1.month
      when "Documentos habilitantes"
        fecha_etapa_estimada = self.created_at + 1.month
        fecha_proxima_etapa =  self.created_at + 2.month
      when "Acta de sorteo judicial"
        fecha_etapa_estimada = self.created_at + 2.month
        fecha_proxima_etapa =  self.created_at + 5.month
      when "Citaciones finalizadas - Razón"
        fecha_etapa_estimada = self.created_at + 5.month
        fecha_proxima_etapa =  self.created_at + 7.month
      when "Sentencia"
        fecha_etapa_estimada = self.created_at + 7.month
        fecha_proxima_etapa =  self.created_at + 8.month
      when "Liquidación"
        fecha_etapa_estimada = self.created_at + 8.month
        fecha_proxima_etapa =  self.created_at + 9.month
      when "Audiencia de ejecución"
        fecha_etapa_estimada = self.created_at + 9.month
        fecha_proxima_etapa =  self.created_at + 11.month
      when "Ejecución de remate"
        fecha_etapa_estimada = self.created_at + 11.month
        fecha_proxima_etapa =  self.created_at + 12.month
      when "Termina proceso"
        fecha_etapa_estimada = self.created_at + 12.month
        return ["terminado", "label label-default"]
    end
    # Si las etapas son iguales quiere decir que solo va a poder estar en rojo
    # o amarillo segun los días transcurrido entre las etapas
    if self.good_stage.name == nombre_etapa_estimada
      # Dias que han pasado desde la etapa hasta ahora
      dias_transcurridos = (Date.current - fecha_etapa_estimada.to_date).to_i
      # Dias totales que existe entre etapa y etapa para poder sacar el 25%
      dias_proxima_etapa = (fecha_proxima_etapa.to_date - fecha_etapa_estimada.to_date)
      # Quiere decir que aún no ha pasado o ya pasó los 0.4 días
      if dias_transcurridos <= (dias_proxima_etapa * 0.4).to_i
        ["verde", "label label-success"]
      else
        ["amarillo", "label label-warning"]
      end
    else # Si las etapas son diferentes quiere decir que o está atrasado o estado adelantado
      # Días que han pasado desde la fecha que empieza la etapa hasta ahora
      # si es negativo quiere decir que esta adelantado y se encuentra en una etapa a futuro
      dias_transcurridos_desde_etapa_actual = (Date.current - fecha_etapa_actual).to_i

      # Almacena los días que hay etapa actual hasta la estimada si es negativo
      # quiere decir que se encuentra  adelantado entre etapas
      dias_entre_etapas = (fecha_etapa_estimada.to_date - fecha_etapa_actual).to_i

      # Si los días que han transcurrido son mayores al numero total de días entre las etapas es
      # porque esta trasado una etapa, se valida que sean positivos porque cuando son negativos
      # quiere decir que esta adelantado
      if ( dias_transcurridos_desde_etapa_actual >= dias_entre_etapas) and dias_entre_etapas > 0
        ["rojo", "label label-danger"]
      else
        ["verde", "label label-success"]
      end
    end
  end

  def self.filtrar_creditos(creditos)
    r = Good.pluck(:credit_id)
    r +=Insolvency.pluck(:credit_id)
    r +=WithoutGood.pluck(:credit_id)
    r +=PendingTrial.pluck(:credit_id)
    r +=DiscardedTrial.pluck(:juicio_id)

    ids_repetidos = Array.new
    creditos.each_with_index do |credit, i|
      # Encuentra y guarda en un array los id_credito repetidos
      if r.include?(credit["id_credito"])
        ids_repetidos.push(credit["id_credito"])
      end
    end

    ids_repetidos.each do |id|
      creditos = self.eliminar_de_array id,creditos
    end
    creditos
  end

  def self.eliminar_de_array(id, array)
    array.each_with_index do |credito, i|
      if credito["id_credito"] == id
        array.delete_at(i)
      end
    end
  end

  def delete_pending
    PendingTrial.find_by(credit_id: self.credit_id).destroy
  end

  def self.buscar_por_idCredito id
    id_original = id
    if id[0] == "R" or id[0] == "I"
      id = id[2..id.length]
    end
    juicio = Good.find_by(:credit_id => id)
    if juicio.nil?
      juicio = WithoutGood.find_by(:credit_id => id_original)
    end
    juicio
  end

  def date_format date
    date.strftime('%B %d, del %Y')
  end

  def skip_callbacks
    self.credit_id[0] == "R" or self.callback_skip == true
  end

  #   Metodo que sirve para ajustar la fecha de creacion de los juicios
  #   para que queden en verde
  def self.ajustar_fechas
    Good.all.each do |juicio|
      if juicio.estado == 'Activo' or juicio.estado == 'Reingreso'
        # nombre_etapa_estimada = juicio.etapa_estimada
        # month = GoodStage.find_by_name(nombre_etapa_estimada).months
        # juicio.update(created_at: Date.current - month.month)
        juicio.update(created_at: Date.current - juicio.good_stage.months.month - 27.day)
      end
    end
  end

  # def self.guardar_creditos_pendientes
  #   good = Good.all.as_json.to_a
  #   withgood = WithoutGood.all.as_json.to_a
  #
  #   juicios = good + withgood
  #   # guardar_creditos_pendientes
  #
  #   filename =  "creditos_nuevos.txt"
  #   file = File.open(Rails.public_path.join("creditos",filename), "wb")
  #   serialized_array = Marshal.dump(juicios)
  #   File.open(file, "wb"){ |f| f << serialized_array }
  # end
end

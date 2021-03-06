class CreateInsolvencies < ActiveRecord::Migration[5.1]
  def change
    create_table :insolvencies do |t|
      t.string :credit_id
      t.string :socio_id
      t.string :nombres
      t.string :cedula
      t.string :telefono
      t.string :celular
      t.string :direccion
      t.string :sector
      t.string :parroquia
      t.string :canton
      t.string :nombre_grupo
      t.string :grupo_solidario
      t.string :sucursal
      t.string :oficial_credito
      t.string :cartera_heredada
      t.string :fecha_concesion
      t.string :fecha_vencimiento
      t.string :tipo_garantia
      t.string :garantia_real
      t.string :garantia_fiduciaria
      t.string :dir_garante
      t.string :tel_garante
      t.string :valor_cartera_castigada
      t.string :bienes
      t.string :tipo_credito
      t.references :insolvency_stage, foreign_key: true
      t.references :insolvency_activity, foreign_key: true
      t.string :estado
      t.text :observaciones
      t.string :juicio_id
      t.date :fentrega_juicios
      t.date :fcalificacion_juicio
      t.string :codigo_juicio

      t.timestamps
    end
  end
end

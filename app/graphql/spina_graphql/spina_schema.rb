SpinaGraphql::SpinaSchema = GraphQL::Schema.define do
  mutation(SpinaGraphql::Types::MutationType)
  query(SpinaGraphql::Types::QueryType)

  resolve_type ->(type, obj, ctx) do
    case obj.class.name
    when 'Spina::Structure'
      return SpinaGraphql::Types::StructureType
    when 'Spina::Photo'
      return SpinaGraphql::Types::PhotoType
    when 'Spina::PhotoCollection'
      return SpinaGraphql::Types::PhotoCollectionType
    else
      return SpinaGraphql::Types::TextType
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    'Record not found'
  end
end

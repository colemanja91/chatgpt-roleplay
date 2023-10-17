module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :character, CharacterType, "Find a character by ID" do
      argument :id, ID
    end

    def character(id:)
      Character.find(id)
    end

    field :characters, [CharacterType], "List characters"
    def characters
      Character.all
    end

    field :openai_models, [OpenaiModelType], "List OpenAI Models"
    def openai_models
      OpenaiService.new.list_models
    end

    field :voice, VoiceType, "Find a voice by ID" do
      argument :id, ID
    end

    def voice(id:)
      Voice.find(id)
    end

    field :voices, [VoiceType], "List voices"
    def voices
      Voice.all.order(name: :asc)
    end

    # Only returning one for now, for simplicity purposes
    field :insult_session, InsultSessionType, "Last insult session"
    def insult_session
      InsultSession.last
    end
  end
end
